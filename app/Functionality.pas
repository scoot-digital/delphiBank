unit Functionality;

interface

  uses
    System.Character;

  function isString(AStringToCheck: string): Boolean;

implementation

  function isString(AStringToCheck: string): Boolean;

  var
    character: Char;

  begin

    Result := True;

    for character in AStringToCheck do

      begin

        if not TCharacter.IsLetter(character) then

        begin

          Result := False;
          Break;

        end;

      end;

  end;

end.
