program delphiBank;

{$APPTYPE CONSOLE}

{$R *.res}


//  Import required units
uses
  System.SysUtils,
  Banking in 'Banking.pas';


//  ----- Global variables  ----- //

var
  //  Initialise new bank class
  bank: TBank;


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
procedure NewInteraction();

  var
  UserInput : string;
  UserDecision : string;

  begin

    //  Ask the user what they would like to do
    Writeln;
    Writeln('What would you like to do?');
    Writeln('(1 - Create an account');
    Writeln('(2 - Make a deposit');
    Writeln('(3 - Make a withdrawal');
    Writeln('(4 - Generate a statement');
    Writeln('(Q - Quit application');
    Readln(UserInput);

    //  Set the user's input to lower case
    UserDecision := LowerCase(UserInput);

    //  Quit the application
    if UserDecision = 'q' then
      QuitApplication()
    //  If anything else was entered, ask the user to try again
    else
      Writeln('Response invalid');
      NewInteraction();
  end;


//  ----- Main program loop ----- //
begin

  try

    //  Create a new Bank object
    bank := TBank.Create;

    //  Begin program main loop
    NewInteraction();

  except

    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);

  end;

end.
