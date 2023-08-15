// SPDX-License-Identifier: MIT
// Omnus Contracts v3
// https://omn.us/spendable
// https://github.com/omnus/ERC20Spendable
// npm: @omnus/ERC20Spendable

/**
 *
 * @title ERC20SpendableReceiver.sol
 *
 * @author omnus
 * https://omn.us
 *
 * @notice ERC20 extension to allow ERC20s to operate as 'spendable' items, i.e. an ERC20 token that
 * can trigger an action on another contract at the same time as being transfered. Similar to ERC677
 * and the hooks in ERC777, but with more of an empasis on interoperability (returned values) than
 * ERC677 and specifically scoped interaction rather than the general hooks of ERC777.
 *
 */

pragma solidity 0.8.19;

import {IERC20SpendableReceiver} from "./IERC20SpendableReceiver.sol";

/**
 *
 * @dev ERC20SpendableReceiver.
 *
 */
abstract contract ERC20SpendableReceiver is IERC20SpendableReceiver {
  address public immutable spendableToken;

  event SpendReceived(address spender_, uint256 spent_, bytes arguments_);

  /**
   *
   * @dev must be passed the token contract for the payable ERC20:
   *
   */
  constructor(address spendableToken_) {
    spendableToken = spendableToken_;
  }

  /**
   *
   * @dev Only allow authorised token:
   *
   */
  modifier onlySpendable(address spendable_) {
    if (spendable_ != spendableToken) {
      revert CallMustBeFromSpendableToken();
    }
    _;
  }

  /**
   *
   * @dev function to be called on receive. Must be overriden, including the addition of a fee check, if required:
   *
   */
  function receiveSpendableERC20(
    address spender_,
    uint256 spent_,
    bytes memory arguments_
  )
    external
    virtual
    onlySpendable(msg.sender)
    returns (bool success_, bytes memory returnArguments_)
  {
    // Must be overriden
  }
}
