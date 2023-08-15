// SPDX-License-Identifier: MIT
// Omnus Contracts v3
// https://omn.us/spendable
// https://github.com/omnus/ERC20Spendable
// npm: @omnus/ERC20Spendable

/**
 *
 * @title ERC20Spendable.sol
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
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

/**
 *
 * @dev ERC20Spendable is an extension of ERC20:
 *
 */
abstract contract ERC20Spendable {
  /**
   *
   * @notice {spend} allows the transfer of the owners token to the receiver, a call on the receiver, and
   * the return of information from the receiver back up the call stack:
   *
   */
  function spend(
    address receiver_,
    uint256 spent_,
    bytes calldata arguments_
  ) external returns (bytes memory) {
    /**
     *
     * @notice Transfer tokens to the receiver contract IF this is a non-0 amount. Don't try and transfer 0, which leaves
     * open the possibility that the call is free. If not, the function call after will fail and revert.
     *
     * @notice We use the standard ERC20 public transfer method for the transfer, which means two things:
     * 1) This can only be called by the token owner (but that is the entire point!)
     * 2) We inherit all of the security checks in this method (e.g. owner has sufficient balance etc.)
     *
     */
    if (spent_ != 0) IERC20(address(this)).transfer(receiver_, spent_);

    /**
     *
     * @dev Perform actions on the receiver and return arguments back up the callstack.
     *
     */
    (bool success, bytes memory returnValues) = IERC20SpendableReceiver(
      receiver_
    ).receiveSpendableERC20(msg.sender, spent_, arguments_);

    require(success, "Token Spend failed");

    return (returnValues);
  }
}
