{*******************************************************}
{                                                       }
{     StreamSec Security Library for Borland Delphi     }
{     StrSecInit Unit                                   }
{                                                       }
{     Copyright (C) 2003 StreamSec Handelsbolag         }
{                                                       }
{*******************************************************}
unit StrSecInit;

interface

procedure InitMPYarrow(Blocking: Boolean = False);
procedure InitSmallPrimes;
procedure InitMPArith;
procedure InitASN1;
procedure InitPKIX_Cert;
procedure InitPKIX_CRL;
procedure InitPKIX_CRMF;
procedure InitPKCS_10;
procedure InitCMS;
procedure InitMPX509;
procedure InitStreamSecII;

implementation

uses
  MPYarrow, MPArith, SmallPrimes, ASN1, PKIX_Cert, PKIX_CRL, PKIX_CRMF, PKCS_10,
  CMS, MPX509, StreamSecII;

var
  IntdMPYarrow: Boolean = False;
  IntdSmallPrimes: Boolean = False;
  IntdMPArith: Boolean = False;
  IntdASN1: Boolean = False;
  IntdPKIX_Cert: Boolean = False;
  IntdPKIX_CRL: Boolean = False;
  IntdPKIX_CRMF: Boolean = False;
  IntdPKCS_10: Boolean = False;
  IntdCMS: Boolean = False;
  IntdMPX509: Boolean = False;
  IntdStreamSecII: Boolean = False;

procedure InitMPYarrow(Blocking: Boolean = False);
begin
  if not IntdMPYarrow then begin
    {$IFNDEF INIT_SECTIONS}
    MPYarrow.CreateGlobalYarrow(Blocking);
    {$ENDIF}
  end;
  IntdMPYarrow := True;
end;

procedure InitSmallPrimes;
begin                 
  if not IntdSmallPrimes then begin
    {$IFNDEF INIT_SECTIONS}
    SmallPrimes.GenPrimes;
    {$ENDIF}
  end;
  IntdSmallPrimes := True;
end;

procedure InitMPArith;
begin
  if not IntdMPArith then begin
    InitMPYarrow;
    InitSmallPrimes;
    {$IFNDEF INIT_SECTIONS}
    MPArith.SetMPPoolSize(MPArith.DefaultPoolSize);
    {$ENDIF}
  end;
  IntdMPArith := True;
end;

procedure InitASN1;
begin
  if not IntdASN1 then begin
    InitMPArith;
    {$IFNDEF INIT_SECTIONS}
    ASN1.InitASN;
    {$ENDIF}
  end;
  IntdASN1 := True;
end;

procedure InitPKIX_Cert;
begin
  if not IntdPKIX_Cert then begin
    InitASN1;
    {$IFNDEF INIT_SECTIONS}
    PKIX_Cert.Initialize;
    {$ENDIF}
  end;
  IntdPKIX_Cert := True;
end;

procedure InitPKIX_CRL;
begin
  if not IntdPKIX_CRL then begin
    InitPKIX_Cert;
    {$IFNDEF INIT_SECTIONS}
    PKIX_CRL.Initialize;
    {$ENDIF}
  end;
  IntdPKIX_CRL := True;
end;

procedure InitPKIX_CRMF;
begin
  if not IntdPKIX_CRMF then begin
    InitPKIX_Cert;
    {$IFNDEF INIT_SECTIONS}
    PKIX_CRMF.Initialize;
    {$ENDIF}
  end;
  IntdPKIX_CRMF := True;
end;

procedure InitPKCS_10;
begin
  if not IntdPKCS_10 then begin
    InitPKIX_Cert;
    {$IFNDEF INIT_SECTIONS}
    PKCS_10.Initialize;
    {$ENDIF}
  end;
  IntdPKCS_10 := True;
end;

procedure InitCMS;
begin
  if not IntdCMS then begin
    InitPKIX_Cert;
    InitPKIX_CRL;
    {$IFNDEF INIT_SECTIONS}
    CMS.Initialize;
    {$ENDIF}
  end;
  IntdCMS := True;
end;

procedure InitMPX509;     
begin
  if not IntdMPX509 then begin
    InitCMS;
    {$IFNDEF INIT_SECTIONS}
    MPX509.Initialize;
    {$ENDIF}
  end;
  IntdMPX509 := True;
end;

procedure InitStreamSecII;
begin
  if not IntdStreamSecII then begin
    InitCMS;
    {$IFNDEF INIT_SECTIONS}
    StreamSecII.Initialize;
    {$ENDIF}
  end;
  IntdStreamSecII := True;
end;

end.
