// SPDX-License-Identifier: MIT
// Omnus Contracts v3
// https://omn.us/spendable
// https://github.com/omnus/ERC20Spendable
// npm: @omnus/ERC20Spendable

/**
 *
 * @title IERC20SpendableErrors.sol
 *
 * @author omnus
 * https://omn.us
 *
 * @notice ERC20 extension to allow ERC20s to operate as 'spendable' items, i.e. an ERC20 token that
 * can trigger an action on another contract at the same time as being transfered. Similar to ERC677
 * and the hooks in ERC777, but with more of an empasis on interoperability (returned values) than
 * ERC677 and specifically scoped interaction rather than the general hooks of ERC777.
 *
 * Interface for custom error definitions
 *
 */

pragma solidity ^0.8.19;

interface IERC20SpendableErrors {
  /// @dev The call to this method can only be from a designated spendable token.
  error CallMustBeFromSpendableToken();

  /// @dev The called contract does not support ERC20Spendable.
  error ERC20SpendableInvalidReveiver(address receiver);

  /// @dev The token spend operation returned success == false.
  error TokenSpendFailed();
}
