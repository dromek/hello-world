unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ECLink, DCPmd5, DCPsha256, DCPsha512, md5;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    CheckBox1: TCheckBox;
    ECLink1: TECLink;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure ECLink1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form1: TForm1;

implementation

uses
  Unit2;

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin
  // jedziemy
  Self.Color := RGBToColor(235, 235, 237);
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  // clean text-box's
  Edit1.Text := EmptyStr;
  Edit2.Text := EmptyStr;
  Edit3.Text := EmptyStr;
  Edit4.Text := EmptyStr;
end;


function MD5(const S: String): String;
var
  i: Byte;
  digest: array[0..15] of Byte;
begin

  with TDCP_md5.Create(nil) do
  begin
    Init;
    Update(S[1], Length(S));
    Final(digest);
    Free;
  end;

  Result := '';
  for i := 0 to Length(digest)-1 do
    Result := Result + IntToHex(digest[i], 2);
  Result := LowerCase(Result);
end;

function SHA256(const S: String): String;
var
  i: Byte;
  digest: array[0..31] of Byte;
begin

  with TDCP_sha256.Create(nil) do
  begin
    Init;
    Update(S[1], Length(S));
    Final(digest);
    Free;
  end;

  Result := '';
  for i := 0 to Length(digest)-1 do
    Result := Result + IntToHex(digest[i], 2);
  Result := LowerCase(Result);
end;

function SHA512(const S: String): String;
var
  i: Byte;
  digest: array[0..63] of Byte;
begin

  with TDCP_sha512.Create(nil) do
  begin
    Init;
    Update(S[1], Length(S));
    Final(digest);
    Free;
  end;

  Result := '';
  for i := 0 to Length(digest)-1 do
    Result := Result + IntToHex(digest[i], 2);
  Result := LowerCase(Result);
end;

procedure TForm1.Button2Click(Sender: TObject);
begin

  if Trim(Edit1.Text) = EmptyStr then begin
     Application.MessageBox('Podaj tekst w polu fraza tekstu', pchar(Self.Caption));
     Exit;
  end;

  Edit2.Text := EmptyStr;
  Edit3.Text := EmptyStr;
  Edit4.Text := EmptyStr;

  if CheckBox1.Checked then begin
    Edit2.Text := UpperCase(MD5(Edit1.Text));
    Edit3.Text := UpperCase(SHA256(Edit1.Text));
    Edit4.Text := UpperCase(SHA512(Edit1.Text));
  end
  else begin
    Edit2.Text := MD5(Edit1.Text);
    Edit3.Text := SHA256(Edit1.Text);
    Edit4.Text := SHA512(Edit1.Text);
  end;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin

end;

procedure TForm1.ECLink1Click(Sender: TObject);
var
   FormAbout: TFormAbout;
begin
  FormAbout := TFormAbout.Create(Application);
  FormAbout.ShowModal();
  FormAbout.Free();
end;

end.

