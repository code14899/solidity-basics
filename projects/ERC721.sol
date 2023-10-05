// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

interface IERC165 {
    function supportsInterface(bytes4 interfaceID) external view returns (bool);
}

interface IERC721 is IERC165 {
    function balanceOf(address owner) external view returns (uint256 balance);

    function ownerOf(uint256 tokenId) external view returns (address owner);

    function safeTransferFrom(
        address from,
        address to,
        uint256 tokenId
    ) external;

    function safeTransferFrom(
        address from,
        address to,
        uint256 tokenId,
        bytes calldata data
    ) external;

    function transferFrom(
        address from,
        address to,
        uint256 tokenId
    ) external;

    function approve(address to, uint256 tokenId) external;

    function getApproved(uint256 tokenId)
        external
        view
        returns (address operator);

    function setApprovalForAll(address operator, bool _approved) external;

    function isApprovedForAll(address owner, address operator)
        external
        view
        returns (bool);
}

// this interface is of the contract that will be receiving nft
// it would be required to check whether the receiving contract is erc721 compatable or not
interface IERC721Receiver {
    function onERC721Received(
        address operator,
        address from,
        uint256 tokenId,
        bytes calldata data
    ) external returns (bytes4);
}

contract ERC721 is IERC721 {
    event Transfer(
        address indexed from,
        address indexed to,
        uint256 indexed id
    );
    event Approval(
        address indexed owner,
        address indexed spender,
        uint256 indexed id
    );
    event ApprovalForAll(
        address indexed owner,
        address indexed operator,
        bool approved
    );

    mapping(uint256 => address) internal _ownerOf; //   nftId -> adderess of owner
    mapping(address => uint256) internal _balanceOf; //   amount of nft which each address own
    mapping(uint256 => address) internal _approvals; //   uint is the nftId and address is the address of the person who was given approval to ctrl the the user's nft
    mapping(address => mapping(address => bool)) public isApprovedForAll; // address of the owner of the nft => (address that was given permission by the owner to spend all his nft => whether the address have the permission

    function supportsInterface(bytes4 interfaceId)
        external
        view
        returns (bool)
    {
        // we have to return true if the interfaceID matches with the interface id of ierc721 or ierc165
        return
            interfaceId == type(IERC721).interfaceId ||
            interfaceId == type(IERC165).interfaceId;
    }

    function balanceOf(address owner) external view returns (uint256 balance) {
        // this function returns the amount of nft owned by owner
        // for erc721 owner cannot be equal to address(0)
        require(owner != address(0), "owner != address(0)");
        return _balanceOf[owner];
    }

    function ownerOf(uint256 tokenId) external view returns (address owner) {
        // owner cannot be address(0)
        owner = _ownerOf[tokenId];
        require(owner != address(0), "owner cannot be address(0)");
    }

    function setApprovalForAll(address operator, bool _approved) external {
        // we are giving operator permission to take ctrl of all my nft or removing that permission from operator
        isApprovedForAll[msg.sender][operator] = _approved;
        emit ApprovalForAll(msg.sender, operator, _approved);
    }

    function approve(address to, uint256 tokenId) external {
        // approved function gives permission to to address to ctrl the tokenId
        address owner = _ownerOf[tokenId];
        require(
            msg.sender == owner || isApprovedForAll[owner][msg.sender],
            "not authorized"
        );

        _approvals[tokenId] = to;
        emit Approval(owner, to, tokenId);
    }

    function getApproved(uint256 tokenId)
        external
        view
        returns (address operator)
    {
        // THIS WILL RETURN THE ADDRESS OF THE PERSON APPROVED TO MANAGE THE TOKEN AT TOKENID
        require(_ownerOf[tokenId] != address(0), "token does not exists");
        return _approvals[tokenId];
    }

    function _isApprovedOrOwner(
        address owner,
        address spender,
        uint256 tokenId
    ) internal view returns (bool) {
        // check whether the spender is the owner of tokenId
        // or spender have the permission to spens the tokenId

        return (spender == owner ||
            isApprovedForAll[owner][spender] ||
            spender == _approvals[tokenId]);
    }
    
    // we will be calling transferFrom inside safeTransfer from so we change it to public
    function transferFrom(
        address from,
        address to,
        uint256 tokenId
    ) public {
        // this function will transfer the ownership of nft from "from" to address "to" for tokenId
        require(from == _ownerOf[tokenId], "from != owner");
        require(to != address(0), "to == zero address");
        // next we are checking the permission 
        require(_isApprovedOrOwner(from, msg.sender, tokenId), "not authorized");

        _balanceOf[from]--;
        _balanceOf[to]++;
        _ownerOf[tokenId] = to;

        // delete keyword is used to reset the value of variables to their default value
        delete _approvals[tokenId];

        emit Transfer(from, to , tokenId);
    }

    function safeTransferFrom(
        address from,
        address to,
        uint256 tokenId
    ) external {
        // similar to transfer from
        // difference is if "to" is a contract than we have to call onERC721Receiver
        transferFrom(from, to , tokenId);

        // to.code.length == 0, this means that the length of the code stored at address "to" is zero
        // this will mean that the "to" address either is not a contract or it is a contract that was just deployed in this transaction
        // if to.code.length is equal to 0 than we dont need to call the function onERC721Receiver 
        // otherwise if the length is greater than zero than we need to call this function

        require(
            to.code.length == 0 || 
            IERC721Receiver(to).onERC721Received(msg.sender, from, tokenId, "") ==
            IERC721Receiver.onERC721Received.selector,
        "unsafe receipient"
        );
        
    }

    function safeTransferFrom(
        address from,
        address to,
        uint256 tokenId,
        bytes calldata data
    ) external {
        
        // similar to safeTransferFrom
        // difference is that as input it is passing some data
        transferFrom(from, to , tokenId);

        require(
            to.code.length == 0 || 
            IERC721Receiver(to).onERC721Received(msg.sender, from, tokenId, data) ==
            IERC721Receiver.onERC721Received.selector,
        "unsafe receipient"
        );
    }

    function _mint(address to, uint tokenId) internal {
        require(to != address(0), "to != zero address");
        require(_ownerOf[tokenId] == address(0), "token exists");

        _balanceOf[to]++;
        _ownerOf[tokenId] = to;

        emit Transfer(address(0), to, tokenId);

    }
    
    function _burn(uint tokenId) internal {
        address owner = _ownerOf[tokenId];
        require(owner != address(0), "token does not exists");

        _balanceOf[owner]--;
        delete _ownerOf[tokenId];
        delete _approvals[tokenId];

        emit Transfer(owner, address(0), tokenId);
    }

}

contract MyNFT is ERC721 {
    function mint(address to, uint tokenId) external {
        _mint(to, tokenId);
    }

    function burn(uint tokenId) external {
        require(msg.sender == _ownerOf[tokenId], "not owner");
        _burn(tokenId);
    }
}
