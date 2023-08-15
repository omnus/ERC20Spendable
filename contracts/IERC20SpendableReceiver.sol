// SPDX-License-Identifier: MIT
// Omnus Contracts v3
// https://omn.us/spendable
// https://github.com/omnus/ERC20Spendable
// npm: @omnus/ERC20Spendable

/**
 *
 * @title IERC20SpendableReceiver.sol
 *
 * @author omnus
 * https://omn.us
 *
 * @notice ERC20 extension to allow ERC20s to operate as 'spendable' items, i.e. an ERC20 token that
 * can trigger an action on another contract at the same time as being transfered. Similar to ERC677
 * and the hooks in ERC777, but with more of an empasis on interoperability (returned values) than
 * ERC677 and specifically scoped interaction rather than the general hooks of ERC777.
 *
 * Interface Definition ERC20SpendableReceiver
 *
 */

pragma solidity 0.8.19;

interface IERC20SpendableReceiver {
  /**
   *
   * @dev function to be called on receive. Must be overriden, including the addition of a fee check, if required:
   *
   */
  function receiveSpendableERC20(
    address spender_,
    uint256 spent_,
    bytes memory arguments_
  ) external returns (bool success_, bytes memory returnArguments_);
}
