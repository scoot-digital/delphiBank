# delphiBank <!-- omit in toc -->

> A basic banking application made with Delphi

## Contents <!-- omit in toc -->

- [Introduction](#introduction)
- [Design](#design)
  - [Program Logical Flow](#program-logical-flow)
  - [Program Interface](#program-interface)
  - [Application Class Models](#application-class-models)
  - [Unit Tests](#unit-tests)
    - [Create an Account](#create-an-account)
    - [Make a Deposit](#make-a-deposit)
    - [Make a Withdrawal](#make-a-withdrawal)
    - [Generate a Mini Statement](#generate-a-mini-statement)
- [Development](#development)
- [Outcome](#outcome)

## Introduction

I was tasked with creating a simple bank server application using a Test-Driven Development methodology.

Requirements for the application were that it must be simple, use only one currency and the user needed to be able to:

- **Create** new accounts
- **Deposit** funds into accounts
- **Withdraw** funds from accounts; and
- Generate mini bank **statements** for accounts

The application was *not* to include:

- **A GUI** - this is a server-only task
- **A database or storage or storage on-disk** - information must only be stored inside objects for the duration of the test suite

The following two pascal units were required:

1. A test unit
2. An object-oriented class model

The purposes of this task were to test if I can:

1. Follow a given task and adapt to a new way of development, using an unfamiliar framework ([DUnitX](https://github.com/VSoftTechnologies/DUnitX))
2. Devise tests to ensure the proper functionality of a program, including:
   - Does the normal use-case work?
   - Do certain cases fail (i.e., overdrawing an account)
3. Design object model classes
4. Manage the memory usage of a program, ensuring no memory leaks occur
5. Balance the complexity of a program, ensuring it is neither under nor over-engineered

## Design

### Program Logical Flow

I began designing this system by considering its logical flow - including the sequence of steps taken, decisions made, and actions performed by users when interacting with it. The logical flow of this program is shown in the flowchart below.

```mermaid
flowchart TD

    start([Start Program])

    welcome[Welcome Message]

    mainMenu[Main Menu]

    createAccount[/Create New Account/]

    openAccount[/Open Existing Account/]

    depositMoney[/Deposit Money/]

    withdrawMoney[/Widthdraw Money/]

    statement[/Print Account Statement/]

    quit([Quit Program])

    start -- Automatically Displayed --> welcome -- Automatically Displayed --> mainMenu -- User Choice --> createAccount & openAccount 

    mainMenu -- User Choice ----> quit   
    
    createAccount -- Automatically Displayed --> mainMenu

    openAccount -- User Choice --> mainMenu

    openAccount -- User Choice --> depositMoney & withdrawMoney & statement
    depositMoney & withdrawMoney & statement -- Automatically Displayed --> openAccount 
    

```

### Program Interface

After plotting the [logical flow](#program-logical-flow) of the program, I considered how the steps, decisions and actions of the program would be presented to the user. As the task specified there should be no GUI for this program, I decided to use an "interaction system". Each interaction includes one or more sequence/s of:

- A **prompt** - which advises the user what they should / can do next
- An opportunity for the user to provide some **input** in response to the given prompt
- **Validation** of the user input - to ensure that the user gave a valid response to the given prompt; and
- **Confirmation** of the user's success in providing a valid response to the given prompt
  - **Note**: If the user's response is deemed invalid, the interaction will begin again

The successful completion of each interaction will trigger the initialisation of the next.

The following flowchart translates the program's logical flow into a graphical representation of these "interactions".

```mermaid
flowchart TB    

    startProcess([Program Start])

    subgraph welcomeInteraction[Welcome Interaction]

        direction TB

        welcomeMessage["#quot;Welcome to delphiBank#quot;"]

    end

    startProcess -- Automatically Displayed --> welcomeInteraction

    subgraph mainMenu[Main Menu]

        direction TB

        mainMenuPrompt["#quot;What would you like to do?#quot;"]

        createAccountOption[/Create a New Account/]

        openAccountOption[/Open an Existing Account/]

        quitProgramOption[/Quit Program/]

        mainMenuPrompt--Automatically Displayed-->createAccountOption & openAccountOption & quitProgramOption
            
    end

    welcomeInteraction -- Automatically Displayed ------> mainMenuPrompt

    subgraph createAccountInteraction["Create Account Interaction"]

        direction TB

        namePrompt["#quot;Please enter the account holder's name#quot;"]
        nameEntry[\Customer Name/]
        nameValidation{Name Valid?}
        nameInvalid["#quot;Name Invalid#quot;"]
        balancePrompt["#quot;Please enter the starting balance of the account#quot;"]
        balanceEntry[\Starting Balance/]
        balanceValidation{Balance valid?}
        balanceInvalid["#quot;Balance Invalid#quot;"]
        createAccountConfirmation["#quot;Account Created Successfully#quot;"]

        namePrompt -- Automatically Displayed --> nameEntry

        nameEntry -- User Input--> nameValidation
        nameValidation -- Yes --> balancePrompt
        nameValidation -- No --> nameInvalid--Automatically Displayed -->namePrompt

        balancePrompt -- Automatically Displayed --> balanceEntry
        balanceEntry -- User Input --> balanceValidation
        balanceValidation -- Yes --> createAccountConfirmation
        balanceValidation -- No --> balanceInvalid--Automatically Displayed -->balancePrompt

    end    

    createAccountOption -- User Choice --> namePrompt
    createAccountConfirmation --Automatically Displayed--> mainMenuPrompt

    subgraph existingAccountMenu["Existing Account Menu"]

        direction TB

        existingAccountPrompt["#quot;What would you like to do?#quot;"]

        depositMoneyOption{Deposit Money}

        withdrawMoneyOption{Withdraw Money}

        statementOption{Print Account Statement}

        exitOption{Exit to Main Menu}

        existingAccountPrompt--Automatically Displayed-->depositMoneyOption & withdrawMoneyOption & statementOption & exitOption
        exitOption -- User Choice --> mainMenuPrompt
       

    end

    openAccountOption -- User Choice --> existingAccountPrompt 

    subgraph withdrawMoneyInteraction[Withdraw Money Interaction]

        direction TB
    
        withdrawMoneyPrompt["#quot;How much would you like to Withdraw?#quot;"]
        withdrawAmountEntry[\Withdraw Amount/]
        withdrawAmountValidationOne{Amount Valid?}
        withdrawAmountValidationTwo{Amount Available?}
        withdrawAmountInvalid["#quot;Amount Invalid#quot;"]
        withdrawAmountUnavailable["#quot;Amount Unavailable#quot;"]
        withdrawMoneyConfirmation["#quot;Amount Withdrawn Successfully#quot;"]

        withdrawMoneyPrompt -- Automatically Displayed --> withdrawAmountEntry

        withdrawAmountEntry -- User Input --> withdrawAmountValidationOne
        withdrawAmountValidationOne -- No --> withdrawAmountInvalid --Automatically Displayed -->withdrawMoneyPrompt
        withdrawAmountValidationOne -- Yes --> withdrawAmountValidationTwo

        withdrawAmountValidationTwo -- Yes --> withdrawMoneyConfirmation
        withdrawAmountValidationTwo -- No --> withdrawAmountUnavailable --Automatically Displayed -->withdrawMoneyPrompt

    end

    withdrawMoneyOption -- User Choice --> withdrawMoneyInteraction
    withdrawMoneyConfirmation-- Automatically Displayed -->existingAccountPrompt

    subgraph depositMoneyInteraction[Deposit Money Interaction]

        direction TB
    
        depositMoneyPrompt["#quot;How much would you like to deposit?#quot;"]
        depositAmountEntry[\Deposit Amount/]
        depositAmountValidation{Amount Valid?}
        depositAmountInvalid["#quot;Amount Invalid#quot;"]
        depositMoneyConfirmation["#quot;Amount Deposited Successfully#quot;"]

        depositMoneyPrompt -- Automatically Displayed --> depositAmountEntry

        depositAmountEntry -- User Input --> depositAmountValidation
        depositAmountValidation -- No --> depositAmountInvalid --Automatically Displayed -->depositMoneyPrompt
        depositAmountValidation -- Yes --> depositMoneyConfirmation

    end

    depositMoneyOption -- User Choice --> depositMoneyInteraction
    depositMoneyConfirmation-- Automatically Displayed -->existingAccountPrompt

    subgraph statementDisplay[Account Statement Display]

        direction TB
    
        accountStatement>Account Statement]

    end

    statementOption -- User Choice --> statementDisplay
    accountStatement-- Automatically Displayed -->existingAccountPrompt

    subgraph quitInteraction["Quit Interaction"]

        direction TB

        quitPrompt["#quot;Thank you for using delphiBank#quot;"]
        quitInput["#quot;Please press enter to quit#quot;"]

        quitPrompt-- Automatically Displayed -->quitInput

    end  

    endProcess([Program End])

    quitProgramOption -- User Choice ----> quitPrompt
    quitInput-- User Presses Enter Key ------> endProcess    

```

### Application Class Models

Once the above flowchart was created to demonstrate how users would the [interface](#program-interface) with this program, I was able to design the classes that would be required by the system. The following UML diagram shows these classes and the relationships and cardinality between them.

```mermaid
classDiagram
    class Bank{
        -accounts Account[]
        +createAccount(_customerName: string, _startingFunds: int) boolean
        +openAccount(_accountNumber: int) Account[]
        +quitApplication() void        
    } 
    class Account{
        -accountNumber int
        -accountOwnerName string
        -transactionHistory Transaction[]
        +deposit(amount : int) boolean
        +withdrawal(_amount : int) boolean
        +printStatement() void
    }
    class Transaction{
        -transactionID int
        -date date
        -type TransactionType
        -amount int
        -status string
        +getTransactionID() int
        +getDate() date
        +getType() TransactionType
        +getAmount() int
        +getStatus() string
        +toString() string
    }
    class TransactionType {
        deposit
        withdrawal
    }
  
    Bank "1" -- "0..*" Account  
    Transaction "1..*" --> "1" Account
    TransactionType "1" --> "0..*" Transaction
```

### Unit Tests

The following tests were devised to ensure the proper functionality of the banking system.

#### Create an Account

|Test No.|Description|Test Instructions|Expected Result|Status|
|---|---|---|---|---|
|1|Ensure new accounts are successfully created|Create an account for a new customer|A new account should be created|Pass or Fail|
|2|Ensure duplicate accounts cannot be created|Create a duplicate account for an already-existing customer|Creation of the account should be denied|Pass or Fail|

#### Make a Deposit

|Test No.|Description|Test Instructions|Expected Result|Status|
|---|---|---|---|---|
|1|Ensure funds are able to be deposited into existing customer accounts|Deposit funds into a customer's account|A deposit should be made into the account|Pass or Fail|
|2|Ensure funds cannot be made into non-existent accounts|Attempt to make a deposit into an account that doesn't exist|The deposit should be denied|Pass or Fail|
|3|Ensure only funds in positive numbers can be deposited|Attempt to make a deposit into an account using a number equal to or less than 0|The deposit should be denied|Pass or Fail|

#### Make a Withdrawal

|Test No.|Description|Test Instructions|Expected Result|Status|
|---|---|---|---|---|
|1|Ensure funds are able to be withdrawn from existing customer accounts|Withdraw funds from a customer's account|A withdrawal should be made from the account|Pass or Fail|
|2|Ensure funds cannot be withdrawn from non-existent accounts|Attempt to make a withdrawal from an account that doesn't exist|The withdrawal should be denied|Pass or Fail|
|3|Ensure only funds in postive numbers can be withdrawn|Attempt to make a withdrawal from an account using a number equal to or less than 0|The withdrawal should be denied|Pass or Fail|

#### Generate a Mini Statement

|Test No.|Description|Test Instructions|Expected Result|Status|
|---|---|---|---|---|
|1|Ensure statements are successfully generated|Generate a statement for an account|A statement should be generated|Pass or Fail|
|2|Ensure statements cannot be created for non-existent accounts|Generate a statement for an account that doesn't exist|Generation of the statement should be denied|Pass or Fail|

## Development

I developed the application using the free [Community Edition](https://www.embarcadero.com/products/delphi/starter) of Delphi 11 via embarcadero.

I will update development of the application later

## Outcome

I will update outcome of the application later
