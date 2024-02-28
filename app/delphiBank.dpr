program delphiBank;

{$APPTYPE CONSOLE}

{$R *.res}


//  Import required units
uses
  System.SysUtils,
  Bank in 'Bank.pas',
  Account in 'Account.pas',
  Functionality in 'Functionality.pas';

//  ----- Global variables  ----- //

var
  //  Initialise new bank class
  Bank: TBank;


//  ----- Functions ----- //

{
  Close the program
}
procedure QuitApplication();

  begin

    Writeln;
    Writeln('Thank you for using delphiBank');
    Writeln('Please press enter to close the program...');

    Readln;

    Halt;

  end;


{
  Start a new interaction with the user, asking what they would like to do
  @param UserInput (string) - represents what the user would like to do
}
procedure MainMenuInteraction();

    begin

      var
        userInput: string;

      //  Ask the user what they would like to do
      Writeln;
      Writeln('Main Menu');
      Writeln('What would you like to do?');
      Writeln('1 - Create a new account');
      Writeln('2 - Open an existing account');
      Writeln('Q - Quit application');
      Readln(userInput);

      //  Set the user's input to lower case
      UserInput := LowerCase(UserInput);

      //  Quit the application
      if UserInput = 'q' then
        QuitApplication()

      //  Create a new account
      else if UserInput = '1' then
        Bank.createAccountInteraction()

      //  Open an existing account
      else if UserInput = '2' then

        begin

          if Bank.getNumAccounts > 0  then

            Bank.openAccountInteraction()

          else

            Writeln('There are no accounts to open');

            MainMenuInteraction()

        end

      //  Handle invalid response
      else

        Writeln('Response invalid');

      MainMenuInteraction();

    end;


//  ----- Main program loop ----- //
begin

  try

    //  Greet the user
    Writeln('Welcome to delphiBank');

    //  Create a new Bank object
    Bank := TBank.Create;

    //  Begin program main loop
    MainMenuInteraction();

  except

    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);

  end;

end.
