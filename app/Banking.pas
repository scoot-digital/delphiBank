{
  Banking unit
  Class for all banking operations
  i.e., creating accounts, depositing and wtihdrawing money and generating account statements
}
unit Banking;


//  Public functions, variables etc.
interface

  uses
  Generics.Collections;
  

  procedure GreetUser();

  type

    { 
      Class for transaction type
    }
    TTransaction = Class
      private

      
      public

      
    End;
    
    {
      Class for account type
    }
    TAccount = Class
    
      private
        FAccountNumber: Integer;
        FAccountOwnwerID: Integer;
        FTransactionHistory: TList<String>;
        FBalance: Currency;   
              
      public
        constructor Create(AAccountOwnerID: Integer; ABalance: currency);
        property AccountOwnerID: Integer read FAccountOwnerID;
        property Balance: currency read FBalance;
            
    End;

    {
      Class for Customer type
    }
    TCustomer = Class

      private
        FCustomerID: Integer;
        FName: string;
        FPhone: Integer;
        FAccounts: TList<Account>;

      public
        constructor Create(AName: string; APhone: Integer);
        property Name: string read Fname;
        property Phone: Integer read FPhone;
        deconstructor Destroy; override;

    End;

    {
      Class for Bank type
    }
    TBank = class

      private
        FCustomers: TList<Customer>
        FAccounts: TList<Account>

      public
        constructor Create;
        deconstructor Destroy; override;

    end;


//  Unit logic
implementation

    {
      Greet the user
    }
    procedure GreetUser();

    begin

          //  Greet the user
          Writeln('Welcome to delphiBank');

    end;


    //  Implement Account class
    constructor TAccount.Create(AAccountOwnerID: Integer; ABalance: currency);
    begin
        FAccountNumber:= Length(Bank.Accounts) + 1;
        FAccountOwnwerID:= AAccountOwnerID;
        FTransactionHistory:= TList<Transaction>.Create
        FBalance:= ABalance 
    end;


    //  Implement Customer class
    constructor TCustomer.Create(AName: string; APhone: Integer);
    begin    
        FCustomerID:= Length(Bank.Customers) + 1; 
        FName:= AName;        
        FPhone:= APhone; 
        FAccounts := TList<Account>.Create;
    end;

    
    //  Implement the Bank class
    constructor TBank.Create;
    begin
      FCustomers := TList<Customer>.Create;
      FAccounts := TList<Account>.Create;
    end;

    deconstructor TBank.Destroy;
    begin
      FCustomers.Free;
      inherited;
    end;

end.
