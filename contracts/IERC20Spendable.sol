// SPDX-License-Identifier: MIT
// Omnus Contracts v3
// https://omn.us/spendable
// https://github.com/omnus/ERC20Spendable
// npm: @omnus/ERC20Spendable

/**
 *
 * @title IERC20Spendable.sol
 *
 * @author omnus
 * https://omn.us
 *
 * @notice ERC20 extension to allow ERC20s to operate as 'spendable' items, i.e. an ERC20 token that
 * can trigger an action on another contract at the same time as being transfered. Similar to ERC677
 * and the hooks in ERC777, but with more of an empasis on interoperability (returned values) than
 * ERC677 and specifically scoped interaction rather than the general hooks of ERC777.
 *
 * Interface Definition IERC20Spendable
 *
 */

pragma solidity 0.8.19;

import {IERC20SpendableErrors} from "./IERC20SpendableErrors.sol";

interface IERC20Spendable is IERC20SpendableErrors {
  /**
   *
   * @dev Spend allows the transfer of the owner's token to the receiver, a call on the receiver, and
   * the return of information from the receiver back up the call stack:
   *
   */
  function spend(
    address receiver_,
    uint256 spent_,
    bytes calldata arguments_
  ) external returns (bytes memory);
}
