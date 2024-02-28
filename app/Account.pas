{

  Account unit
  Class for all account operations
  i.e., depositing and withdrawing money and generating account statements

}
unit Account;

  //  Public functions, variables etc.
  interface

    uses
    Generics.Collections,
    System.SysUtils,
    Transaction;

    type

      {
        Class for Bank type
      }
      TAccount = class

        private
          FAccountNumber: integer;
          FAccountOwnerName: string;
          FTransactionHistory: TList<TTransaction>;

        public
          constructor Create(AAccountNumber: integer; AAccountOwnerName: string);
          destructor Destroy; override;
          function getAccountDetails: TList<String>;
          procedure depositInteraction;
          procedure withdrawInteraction;
          function getBalance: integer;
          procedure printStatement;

    end;

  implementation

    //  Implement the Account class
    constructor TAccount.Create(AAccountNumber: integer; AAccountOwnerName: string);
      begin

        self.FAccountNumber := AAccountNumber;
        self.FAccountOwnerName := AAccountOwnerName;
        self.FTransactionHistory := TList<TTransaction>.create();

      end;


    destructor TAccount.Destroy;
      begin

        FTransactionHistory.Free;
        inherited;

      end;


    //  Implement method to return account number and owner for the banking class' open account interaction
    function TAccount.getAccountDetails(): TList<String>;

      begin

        Result := TList<String>.Create;

        Result.Add(IntToStr(self.FAccountNumber));
        Result.Add(FAccountOwnerName);

      end;


    //  Implement deposit interaction
    procedure TAccount.depositInteraction();

    var
      userInput: string;
      depositAmount: integer;
      newTransaction: TTransaction;
      transactionID: string;


    begin

      //  Ask the user what they would like to deposit
      Writeln(sLineBreak + 'Please enter the amount you wish to deposit (in Australian dollars)');
      Readln(userInput);

      //  Deposit funds if user input valid
      if TryStrToInt(userInput, depositAmount) then

        if depositAmount > 0 then

          begin

            transactionID := IntToStr(self.FAccountNumber) + '-' + IntToStr(self.FTransactionHistory.Count);

            newTransaction:= TTransaction.Create(transactionID, Now, Deposit, depositAmount, Success);

            self.FTransactionHistory.Add(newTransaction);

            Writeln('Depositted $' + userInput);

          end

        else

          begin

            Writeln('Response invalid');
            self.depositInteraction();

          end

      else

        begin

          Writeln('Response invalid');
          self.depositInteraction();

        end

    end;


    //  Implement withdrawal interaction
    procedure TAccount.withdrawInteraction();

    begin



    end;


    //  Implement function to calculate available balance
    function TAccount.getBalance(): integer;

      var
        transaction: TTransaction;

      begin

        Result:= 0;

        for transaction in self.FTransactionHistory do

          result := result + transaction.getAmount();

      end;


    //  Implement procedure to print statement
    procedure TAccount.printStatement();

      var
        transaction: TTransaction;

      begin

        //  Notify the user
        Writeln(sLineBreak + 'Printing statement...');

        Writeln(sLineBreak + 'Account No. ' + IntToStr(self.FAccountNumber) + ', Owner: ' + self.FAccountOwnerName);
        Writeln('Available balance: $' + IntToStr(self.getbalance()));
        Writeln(sLineBreak + 'Transaction History:');

        for transaction in self.FTransactionHistory do

          Writeln(transaction.ToString());

        Writeln(sLineBreak + 'End of statement');

      end;

end.
