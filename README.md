# ERC20Spendable

ERC20Spendable repository

# Solidity API

## ERC20Spendable

\_Implementation of {ERC20Spendable}.

{ERC20Spendable} allows ERC20s to operate as 'spendable' items, i.e. an ERC20 token that
can trigger an action on another contract at the same time as being transfered. Similar to ERC677
and the hooks in ERC777, but with more of an empasis on interoperability (returned values) than
ERC677 and specifically scoped interaction rather than the general hooks of ERC777.

For more detailed notes please see our guide https://omn.us/how-to-implement-erc20-spendable_

### spend

```solidity
function spend(address receiver_, uint256 spent_) public virtual
```

\_{spend} Allows the transfer of the owners token to the receiver, a call on the receiver,
and then the return of information from the receiver back up the call stack.

Overloaded method - call this if you are not specifying any arguments.\_

#### Parameters

| Name       | Type    | Description                                                                                                                                                                          |
| ---------- | ------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| receiver\_ | address | The receiving address for this token spend. Contracts must implement ERCSpendableReceiver to receive spendadle tokens. For more detail see {ERC20SpendableReceiver}.                 |
| spent\_    | uint256 | The amount of token being spent. This will be transfered as part of this call and provided as an argument on the call to {onERC20SpendableReceived} on the {ERC20SpendableReceiver}. |

### spend

```solidity
function spend(address receiver_, uint256 spent_, bytes arguments_) public virtual
```

\_{spend} Allows the transfer of the owners token to the receiver, a call on the receiver, and
the return of information from the receiver back up the call stack.

Overloaded method - call this to specify a bytes argument.\_

#### Parameters

| Name        | Type    | Description                                                                                                                                                                          |
| ----------- | ------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| receiver\_  | address | The receiving address for this token spend. Contracts must implement ERCSpendableReceiver to receive spendadle tokens. For more detail see {ERC20SpendableReceiver}.                 |
| spent\_     | uint256 | The amount of token being spent. This will be transfered as part of this call and provided as an argument on the call to {onERC20SpendableReceived} on the {ERC20SpendableReceiver}. |
| arguments\_ | bytes   | Bytes argument to send with the call. See {mock} contracts for details on encoding and decoding arguments from bytes.                                                                |

### \_handleReceipt

```solidity
function _handleReceipt(bytes arguments_) internal virtual
```

\_{\_handleReceipt} Internal function called on completion of a call to {onERC20SpendableReceived}
on the {ERC20SpendableReceiver}.

When making a token {ERC20Spendable} if you wish to process receipts you need to override
{_handleReceipt} in your contract. For an example, see {mock} contract {MockSpendableERC20ReturnedArgs}._

#### Parameters

| Name        | Type  | Description                                                                                                               |
| ----------- | ----- | ------------------------------------------------------------------------------------------------------------------------- |
| arguments\_ | bytes | Bytes argument to returned from the call. See {mock} contracts for details on encoding and decoding arguments from bytes. |

### supportsInterface

```solidity
function supportsInterface(bytes4 interfaceId_) public view virtual returns (bool)
```

_See {IERC165-supportsInterface}. This can be used to determine if an ERC20 is ERC20Spendable. For
example, a DEX may check this value, and make use of a single {spend} transaction (rather than the current
model of [approve -> pull]) if the ERC20Spendable interface is supported._

#### Parameters

| Name          | Type   | Description                                    |
| ------------- | ------ | ---------------------------------------------- |
| interfaceId\_ | bytes4 | The bytes4 interface identifier being checked. |

## ERC20SpendableReceiver

\_Implementation of {ERC20Spendable}.

{ERC20Spendable} allows ERC20s to operate as 'spendable' items, i.e. an ERC20 token that
can trigger an action on another contract at the same time as being transfered. Similar to ERC677
and the hooks in ERC777, but with more of an empasis on interoperability (returned values) than
ERC677 and specifically scoped interaction rather than the general hooks of ERC777.

For more detailed notes please see our guide https://omn.us/how-to-implement-erc20-spendable_

### spendableToken

```solidity
address spendableToken
```

_Store of the spendable token for this contract. Only calls from this address will be accepted._

### constructor

```solidity
constructor(address spendableToken_) internal
```

_The constructor must be passed the token contract for the payable ERC20._

#### Parameters

| Name             | Type    | Description                        |
| ---------------- | ------- | ---------------------------------- |
| spendableToken\_ | address | The valid spendable token address. |

### onlySpendable

```solidity
modifier onlySpendable(address spendable_)
```

_The constructor must be passed the token contract for the payable ERC20._

#### Parameters

| Name        | Type    | Description                |
| ----------- | ------- | -------------------------- |
| spendable\_ | address | The queried token address. |

### onERC20SpendableReceived

```solidity
function onERC20SpendableReceived(address spender_, uint256 spent_, bytes arguments_) external virtual returns (bytes4 retval_, bytes returnArguments_)
```

\_{onERC20SpendableReceived} External function called by ERC20SpendableTokens. This
validates that the token is valid and then calls the internal {\_handleSpend} method.
You must overried {\_handleSpend} in your contract to perform processing you wish to occur
on token spend.

This method will pass back the valid bytes4 selector and any bytes argument passed from
{_handleSpend}._

#### Parameters

| Name        | Type    | Description                             |
| ----------- | ------- | --------------------------------------- |
| spender\_   | address | The address spending the ERC20Spendable |
| spent\_     | uint256 | The amount of token spent               |
| arguments\_ | bytes   | Bytes sent with the call                |

### \_handleSpend

```solidity
function _handleSpend(address spender_, uint256 spent_, bytes arguments_) internal virtual returns (bytes returnArguments_)
```

\_{\_handleSpend} Internal function called by {onERC20SpendableReceived}.

You must overried {_handleSpend} in your contract to perform processing you wish to occur
on token spend._

#### Parameters

| Name        | Type    | Description                             |
| ----------- | ------- | --------------------------------------- |
| spender\_   | address | The address spending the ERC20Spendable |
| spent\_     | uint256 | The amount of token spent               |
| arguments\_ | bytes   | Bytes sent with the call                |

## IERC20Spendable

\_Implementation of {IERC20Spendable} interface.

{ERC20Spendable} allows ERC20s to operate as 'spendable' items, i.e. an ERC20 token that
can trigger an action on another contract at the same time as being transfered. Similar to ERC677
and the hooks in ERC777, but with more of an empasis on interoperability (returned values) than
ERC677 and specifically scoped interaction rather than the general hooks of ERC777.

For more detailed notes please see our guide https://omn.us/how-to-implement-erc20-spendable_

### ERC20SpendableInvalidReveiver

```solidity
error ERC20SpendableInvalidReveiver(address receiver)
```

_Error {ERC20SpendableInvalidReveiver} The called contract does not support ERC20Spendable._

### spend

```solidity
function spend(address receiver_, uint256 spent_) external
```

\_{spend} Allows the transfer of the owners token to the receiver, a call on the receiver,
and then the return of information from the receiver back up the call stack.

Overloaded method - call this if you are not specifying any arguments.\_

#### Parameters

| Name       | Type    | Description                                                                                                                                                                          |
| ---------- | ------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| receiver\_ | address | The receiving address for this token spend. Contracts must implement ERCSpendableReceiver to receive spendadle tokens. For more detail see {ERC20SpendableReceiver}.                 |
| spent\_    | uint256 | The amount of token being spent. This will be transfered as part of this call and provided as an argument on the call to {onERC20SpendableReceived} on the {ERC20SpendableReceiver}. |

### spend

```solidity
function spend(address receiver_, uint256 spent_, bytes arguments_) external
```

\_{spend} Allows the transfer of the owners token to the receiver, a call on the receiver, and
the return of information from the receiver back up the call stack.

Overloaded method - call this to specify a bytes argument.\_

#### Parameters

| Name        | Type    | Description                                                                                                                                                                          |
| ----------- | ------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| receiver\_  | address | The receiving address for this token spend. Contracts must implement ERCSpendableReceiver to receive spendadle tokens. For more detail see {ERC20SpendableReceiver}.                 |
| spent\_     | uint256 | The amount of token being spent. This will be transfered as part of this call and provided as an argument on the call to {onERC20SpendableReceived} on the {ERC20SpendableReceiver}. |
| arguments\_ | bytes   | Bytes argument to send with the call. See {mock} contracts for details on encoding and decoding arguments from bytes.                                                                |

## IERC20SpendableReceiver

\_Implementation of {IERC20SpendableReceiver} interface.

{ERC20Spendable} allows ERC20s to operate as 'spendable' items, i.e. an ERC20 token that
can trigger an action on another contract at the same time as being transfered. Similar to ERC677
and the hooks in ERC777, but with more of an empasis on interoperability (returned values) than
ERC677 and specifically scoped interaction rather than the general hooks of ERC777.

For more detailed notes please see our guide https://omn.us/how-to-implement-erc20-spendable_

### CallMustBeFromSpendableToken

```solidity
error CallMustBeFromSpendableToken()
```

@dev Error {CallMustBeFromSpendableToken}. The call to this method can only be from a designated spendable token.

### onERC20SpendableReceived

```solidity
function onERC20SpendableReceived(address spender_, uint256 spent_, bytes arguments_) external returns (bytes4 retval_, bytes returnArguments_)
```

\_{onERC20SpendableReceived} External function called by ERC20SpendableTokens. This
validates that the token is valid and then calls the internal {\_handleSpend} method.
You must overried {\_handleSpend} in your contract to perform processing you wish to occur
on token spend.

This method will pass back the valid bytes4 selector and any bytes argument passed from
{_handleSpend}._

#### Parameters

| Name        | Type    | Description                             |
| ----------- | ------- | --------------------------------------- |
| spender\_   | address | The address spending the ERC20Spendable |
| spent\_     | uint256 | The amount of token spent               |
| arguments\_ | bytes   | Bytes sent with the call                |

## MockSpendableERC20

### constructor

```solidity
constructor(address initialHolder_, uint256 intialBalance_) public
```

## MockSpendableERC20Receiver

### AmountStaked

```solidity
event AmountStaked(uint256 stake, string message, uint256 stakeDays)
```

### stakedAmount

```solidity
mapping(address => uint256) stakedAmount
```

### constructor

```solidity
constructor(address spendableToken_) public
```

### \_handleSpend

```solidity
function _handleSpend(address spender_, uint256 spent_, bytes arguments_) internal returns (bytes returnArguments_)
```

_function to be called on receive._

## MockSpendableERC20ReturnedArgs

### Receipt

```solidity
event Receipt(address spender, uint256 spent, bool flag)
```

### constructor

```solidity
constructor(address initialHolder_, uint256 intialBalance_) public
```

### \_handleReceipt

```solidity
function _handleReceipt(bytes arguments_) internal
```

_function to be called on receive._

## IERC20SpendableErrors

### CallMustBeFromSpendableToken

```solidity
error CallMustBeFromSpendableToken()
```

@dev The call to this method can only be from a designated spendable token.

### ERC20SpendableInvalidReveiver

```solidity
error ERC20SpendableInvalidReveiver(address receiver)
```

_The called contract does not support ERC20Spendable._

### TokenSpendFailed

```solidity
error TokenSpendFailed()
```

_The token spend operation returned success == false._

## MockSpendableERC20NonReceiver

### constructor

```solidity
constructor() public
```
