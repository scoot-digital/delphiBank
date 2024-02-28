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
    System.SysUtils;

    type

      {
        Class for Bank type
      }
      TAccount = class

        private
          FAccountNumber: integer;
          FAccountOwnerName: string;
          FTransactionHistory: TList<string>;

        public
          constructor Create(AAccountNumber: integer; AAccountOwnerName: string);
          destructor Destroy; override;
          function getAccountDetails(): TList<String>;
          procedure depositInteraction();
          procedure withdrawInteraction();
          procedure printStatement();

    end;

  implementation

    //  Implement the Account class
    constructor TAccount.Create(AAccountNumber: integer; AAccountOwnerName: string);
    begin

      self.FAccountNumber := AAccountNumber;
      self.FAccountOwnerName := AAccountOwnerName;
      self.FTransactionHistory := TList<string>.create();

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
      depositDetails: string;

    begin

        //  Initialise variable storing deposit details
        depositDetails := 'Deposit: ';

        //  Ask the user what they would like to deposit
        Writeln;
        Writeln('Please enter the amount you wish to deposit (in Australian dollars)');
        Readln(userInput);

        //  Deposit funds if user input valid
        if TryStrToInt(userInput, depositAmount) then

          if depositAmount > 0 then

            begin

              depositDetails := depositDetails + userInput;
              self.FTransactionHistory.Add(depositDetails);

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


    //  Implement interaction to print statement
    procedure TAccount.printStatement();

    begin



    end;

end.