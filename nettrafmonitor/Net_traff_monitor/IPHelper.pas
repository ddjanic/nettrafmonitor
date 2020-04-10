unit IPHelper;


interface

uses
  Windows, Messages, SysUtils, Classes, Dialogs, IpHlpApi;

const
  NULL_IP       = '  0.  0.  0.  0';


type
  TWellKnownPort = record
    Prt: DWORD;
    Srv: string[20];
  end;

  PTTcpConnStatus = ^TTcpConnStatus;
  TTcpConnStatus = record
    LocalIP      : string;
    LocalPort    : string;
    RemoteIP     : string;
    RemotePort   : string;
    Status       : string;
  end;


const
    // services...
  WellKnownPorts: array[1..29] of TWellKnownPort
  = (
    ( Prt: 0; Srv: 'LOOPBACK'),
    ( Prt: 7; Srv: 'ECHO' ),      {Ping    }
    ( Prt: 9; Srv: 'DISCRD' ),    { Discard}
    ( Prt: 13; Srv: 'DAYTIM' ),   {DayTime}
    ( Prt: 17; Srv: 'QOTD' ),     {Quote Of The Day}
    ( Prt: 19; Srv: 'CHARGEN' ),  {CharGen}
    ( Prt: 20; Srv: 'FTP ' ),     { File Transfer Protocol}
    ( Prt: 21; Srv: 'FTPC' ),     { File Transfer Control Protocol}
    ( Prt: 23; Srv: 'TELNET' ),   {TelNet}
    ( Prt: 25; Srv: 'SMTP' ),     { Simple Mail Transfer Protocol}
    ( Prt: 37; Srv: 'TIME' ),     { Time Protocol }
    ( Prt: 43; Srv: 'WHOIS'),     { WHO IS service  }
    ( Prt: 53; Srv: 'DNS ' ),     { Domain Name Service }
    ( Prt: 67; Srv: 'BOOTPS' ),   { BOOTP Server }
    ( Prt: 68; Srv: 'BOOTPC' ),   { BOOTP Client }
    ( Prt: 69; Srv: 'TFTP' ),     { Trivial FTP  }
    ( Prt: 70; Srv: 'GOPHER' ),   { Gopher       }
    ( Prt: 79; Srv: 'FING' ),     { Finger       }
    ( Prt: 80; Srv: 'HTTP' ),     { HTTP         }
    ( Prt: 88; Srv: 'KERB' ),     { Kerberos     }
    ( Prt: 109; Srv: 'POP2' ),    { Post Office Protocol Version 2 }
    ( Prt: 110; Srv: 'POP3' ),    { Post Office Protocol Version 3 }
    ( Prt: 119; Srv: 'NNTP' ),    { Network News Transfer Protocol }
    ( Prt: 123; Srv: 'NTP ' ),    { Network Time protocol          }
    ( Prt: 135; Srv: 'LOCSVC'),   { Location Service              }
    ( Prt: 137; Srv: 'NBNAME' ),  { NETBIOS Name service          }
    ( Prt: 138; Srv: 'NBDGRAM' ), { NETBIOS Datagram Service     }
    ( Prt: 139; Srv: 'NBSESS' ),  { NETBIOS Session Service        }
    ( Prt: 161; Srv: 'SNMP' )     { Simple Netw. Management Protocol }
    );


//-----------ICMP error codes to strings--------------------------

const
  ICMP_ERROR_BASE = 11000;
  IcmpErr : array[1..22] of string =
  (
   'IP_BUFFER_TOO_SMALL','IP_DEST_NET_UNREACHABLE', 'IP_DEST_HOST_UNREACHABLE',
   'IP_PROTOCOL_UNREACHABLE', 'IP_DEST_PORT_UNREACHABLE', 'IP_NO_RESOURCES',
   'IP_BAD_OPTION','IP_HARDWARE_ERROR', 'IP_PACKET_TOO_BIG', 'IP_REQUEST_TIMED_OUT',
   'IP_BAD_REQUEST','IP_BAD_ROUTE', 'IP_TTL_EXPIRED_TRANSIT',
   'IP_TTL_EXPIRED_REASSEM','IP_PARAMETER_PROBLEM', 'IP_SOURCE_QUENCH',
   'IP_OPTION_TOO_BIG', 'IP_BAD_DESTINATION','IP_ADDRESS_DELETED',
   'IP_SPEC_MTU_CHANGE', 'IP_MTU_CHANGE', 'IP_UNLOAD'
  );


//----------values to strings----------------//

  ARPEntryType  : array[1..4] of string = ( 'Other', 'Invalid',
    'Dynamic', 'Static'
    );

  TCPConnState  :      // TCP connection
    array[1..12] of string =
    ( 'closed', 'listening', 'syn_sent',
    'syn_rcvd', 'established', 'fin_wait1',
    'fin_wait2', 'close_wait', 'closing',
    'last_ack', 'time_wait', 'delete_tcb'
    );

  TCPToAlgo     : array[1..4] of string =  // TCP time out algorithms
    ( 'Const.Timeout', 'MIL-STD-1778',
    'Van Jacobson', 'Other' );

  IPForwTypes   : array[1..4] of string =   // IP forwarding methods
    ( 'other', 'invalid', 'local', 'remote' );

  IPForwProtos  : array[1..18] of string =  // IP forwarding protocols
    ( 'OTHER', 'LOCAL', 'NETMGMT', 'ICMP', 'EGP',
    'GGP', 'HELO', 'RIP', 'IS_IS', 'ES_IS',
    'CISCO', 'BBN', 'OSPF', 'BGP', 'BOOTP',
    'AUTO_STAT', 'STATIC', 'NOT_DOD' );


//---------------exported-----------------------------------------------

// data output to Tstrings for display purposes
procedure Get_AdaptersInfo( List: TStrings );
procedure Get_NetworkParams( List: TStrings );
procedure Get_ARPTable( List: TStrings );
procedure Get_TCPTable( List: TStrings );
procedure Get_TCPStatistics( List: TStrings );
procedure Get_UDPTable( List: TStrings );
procedure Get_UDPStatistics( List: TStrings );
procedure Get_IPAddrTable( List: TStrings );
procedure Get_IPForwardTable( List: TStrings );
procedure Get_IPStatistics( List: TStrings );
function Get_RTTAndHopCount( IPAddr: DWORD; MaxHops: Longint;
  var RTT: longint; var HopCount: longint ): integer;
procedure Get_ICMPStats( ICMPIn, ICMPOut: TStrings );
procedure Get_IfTable( NameList, ItemList: TStrings );
procedure Get_IfTableMIB( var MIBIfArray: TMIBIfArray );
procedure Get_IPAddrTableMIB( var IPAddrTable:TMibIPAddrArray  );



procedure Get_RecentDestIPs( List: TStrings );

// added functions
procedure Get_OpenConnections( List: TList );



// conversion utils
function MacAddr2Str( MacAddr: TMacAddress; size: integer ): string;
function IpAddr2Str( IPAddr: DWORD ): string;
function Str2IpAddr( IPStr: string ): DWORD;
function Port2Str( nwoPort: DWORD ): string;
function Port2Wrd( nwoPort: DWORD ): DWORD;
function Port2Svc( Port: DWORD ): string;
function ICMPErr2Str( ICMPErrCode: DWORD) : string;

implementation

var
  RecentIPs     : TStringList;

//--------------General-----------------------------------------------

function NextToken( var s: string; Separator: char ): string;
var
  Sep_Pos       : byte;
begin
  Result := '';
  if length( s ) > 0 then begin
    Sep_Pos := pos( Separator, s );
    if Sep_Pos > 0 then begin
      Result := copy( s, 1, Pred( Sep_Pos ) );
      Delete( s, 1, Sep_Pos );
    end
    else begin
      Result := s;
      s := '';
    end;
  end;
end;

//------------------------------------------------------------------------------
{ converts MAC-address to ww-xx-yy-zz string }
function MacAddr2Str( MacAddr: TMacAddress; size: integer ): string;
var
  i             : integer;
begin
  if Size = 0 then
  begin
    Result := '00-00-00-00-00-00';
    EXIT;
  end
  else Result := '';
  //
  for i := 1 to Size do
    Result := Result + IntToHex( MacAddr[i], 2 ) + '-';
  Delete( Result, Length( Result ), 1 );
end;

//------------------------------------------------------------------------------
function IpAddr2Str( IPAddr: DWORD ): string;
var
  i             : integer;
begin
  Result := '';
  for i := 1 to 4 do
  begin
    Result := Result + Format( '%3d.', [IPAddr and $FF] );
    IPAddr := IPAddr shr 8;
  end;
  Delete( Result, Length( Result ), 1 );
end;

//------------------------------------------------------------------------------
function Str2IpAddr( IPStr: string ): DWORD;
var
  i             : integer;
  Num           : DWORD;
begin
  Result := 0;
  for i := 1 to 4 do
  try
    Num := ( StrToInt( NextToken( IPStr, '.' ) ) ) shl 24;
    Result := ( Result shr 8 ) or Num;
  except
    Result := 0;
  end;

end;

//------------------------------------------------------------------------------
function Port2Wrd( nwoPort: DWORD ): DWORD;
begin
  Result := Swap( WORD( nwoPort ) );
end;

//------------------------------------------------------------------------------
function Port2Str( nwoPort: DWORD ): string;
begin
  Result := IntToStr( Port2Wrd( nwoPort ) );
end;

//------------------------------------------------------------------------------
function Port2Svc( Port: DWORD ): string;
var
  i             : integer;
begin
  Result := Format( '%4d', [Port] ); // port not found
  for i := Low( WellKnownPorts ) to High( WellKnownPorts ) do
    if Port = WellKnownPorts[i].Prt then
    begin
      Result := WellKnownPorts[i].Srv;
      BREAK;
    end;
end;

//-----------------------------------------------------------------------------
{ general network parameters }
procedure Get_NetworkParams( List: TStrings );
var
  InfoSize      : Longint;
  ErrorCode     : DWORD;
  pBuf          : PChar;
begin
  if not Assigned( List ) then EXIT;
  List.Clear;
  InfoSize := 0;
  ErrorCode := GetNetworkParams( PTFixedInfo(pBuf), @InfoSize );
  GetMem( pBuf, InfoSize );
  ErrorCode := GetNetworkParams( PTFixedInfo(pBuf), @InfoSize );
  if ErrorCode = ERROR_SUCCESS then
    with PTFixedinfo(pBuf)^ do
    begin
      List.Add( 'HOSTNAME          : ' + string( HostName ) );
      List.Add( 'DOMAIN            : ' + string( DomainName ) );
      List.Add( 'SCOPE             : ' + string( ScopeID ) );
      List.Add( 'NETBIOS NODE TYPE : ' + NETBIOSTypes[NodeType] );
      List.Add( 'ROUTING ENABLED   :' + IntToStr( EnableRouting ) );
      List.Add( 'PROXY   ENABLED   :' + IntToStr( EnableProxy ) );
      List.Add( 'DNS     ENABLED   :' + IntToHex( EnableDNS,8 ) );
    end
  else
    List.Add( SysErrorMessage( ErrorCode ) );
  FreeMem(pBuf);
end;

//------------------------------------------------------------------------------
function ICMPErr2Str( ICMPErrCode: DWORD) : string;
var
 i : integer;
begin
   Result := 'UnknownError : ' + IntToStr( ICMPErrCode );
   dec( ICMPErrCode, ICMP_ERROR_BASE );
   if ICMPErrCode in [Low(ICMpErr)..High(ICMPErr)] then
     Result := ICMPErr[ ICMPErrCode];
end;




//------------------------------------------------------------------------------
procedure Get_IfTable( NameList, ItemList: TStrings );
var
  IfRow         : TMibIfRow;
  i,
    Error,
    TableSize   : integer;
  pBuf          : PChar;
  NumEntries    : DWORD;
  sDescr,
    Temp        : string;
begin
  if (not Assigned( NameList ))
  or (not Assigned( ItemList ))  then EXIT;
  NameList.Clear;
  ItemList.Clear;
  TableSize := 0;
  Error := GetIfTable( PTMibIfTable( pBuf ), @TableSize, false );
  if Error <> ERROR_INSUFFICIENT_BUFFER then
    EXIT;
  GetMem( pBuf, TableSize );

   // get table pointer
  Error := GetIfTable( PTMibIfTable( pBuf ), @TableSize, false );
  if Error = NO_ERROR then
  begin
    NumEntries := PTMibIfTable( pBuf )^.dwNumEntries;
    if NumEntries > 0 then
    begin
      inc( pBuf, SizeOf( NumEntries ) );
      for i := 1 to NumEntries do
      begin
        IfRow := PTMibIfRow( pBuf )^;
        with IfRow do
        begin
          SetLength( sDescr, dwDescrLen );
          move( bDescr, sDescr[1], Length( sDescr ) );
          sDescr := trim( sDescr );
          NameList.Add( sDescr );
          ItemList.Add( Format( '%0.8x|%2d| %16s| %4d| %8d| %8d| %8d',
            [dwIndex, dwType,
            MacAddr2Str( TMacAddress( bPhysAddr ), dwPhysAddrLen )
              , dwMTU, dwSpeed,
              dwInOctets, dwOutOctets,
              dwOPerStatus] )
              );
        end;
        inc( pBuf, SizeOf( IfRow ) );
      end;
    end
    else  begin
      NameList.Add( 'no entries');
      ItemList.Add( 'no data' );
    end;
  end
  else begin
    NameList.Add( 'Oops');
    ItemList.Add( SysErrorMessage( GetLastError ) );
  end;
  dec( pBuf, SizeOf( DWORD ) + NumEntries * SizeOf( IfRow ) );
  FreeMem( pBuf );
end;



//------------------------------------------------------------------------------
procedure Get_IfTableMIB( var MIBIfArray: TMIBIfArray );
var
  i,
    Error,
    TableSize   : integer;
  pBuf          : PChar;
  NumEntries    : DWORD;
  sDescr,
    Temp        : string;
begin
  TableSize := 0;
   // first call: get memsize needed
  Error := GetIfTable( PTMibIfTable( pBuf ), @TableSize, false );
  if Error <> ERROR_INSUFFICIENT_BUFFER then
    EXIT;
  GetMem( pBuf, TableSize );

   // get table pointer
  Error := GetIfTable( PTMibIfTable( pBuf ), @TableSize, false );
  if Error = NO_ERROR then
  begin
    NumEntries := PTMibIfTable( pBuf )^.dwNumEntries;
    if NumEntries > 0 then
    begin
      SetLength( MIBIfArray, NumEntries );
      inc( pBuf, SizeOf( NumEntries ) );
      for i := 0 to pred(NumEntries) do
      begin
        MIBIfArray[i] := PTMibIfRow( pBuf )^;
        inc( pBuf, SizeOf( TMIBIfRow ) );
      end;
    end
  end;
  dec( pBuf, SizeOf( DWORD ) + NumEntries * SizeOf( TMIBIfRow ) );
  FreeMem( pBuf );
end;



//------------------------------------------------------------------------------
procedure Get_IPAddrTableMIB( var IPAddrTable:TMibIPAddrArray  );
var
  IPAddrRow     : TMibIPAddrRow;
  TableSize     : DWORD;
  ErrorCode     : DWORD;
  i             : integer;
  pBuf          : PChar;
  NumEntries    : DWORD;
begin
  TableSize := 0; ;
  ErrorCode := GetIpAddrTable( PTMibIPAddrTable( pBuf ), @TableSize, true );
  if Errorcode <> ERROR_INSUFFICIENT_BUFFER then
    EXIT;

  GetMem( pBuf, TableSize );
  // get table
  ErrorCode := GetIpAddrTable( PTMibIPAddrTable( pBuf ), @TableSize, true );
  if ErrorCode = NO_ERROR then
  begin
    NumEntries := PTMibIPAddrTable( pBuf )^.dwNumEntries;
    if NumEntries > 0 then
    begin
      SetLength( IPAddrTable, NumEntries);
      inc( pBuf, SizeOf( DWORD ) );
      for i := 1 to NumEntries do
      begin
        IPAddrTable[ i-1 ] := PTMIBIPAddrRow( pBuf )^;
        inc( pBuf, SizeOf( TMIBIPAddrRow ) );
      end;
    end;
  end;

  // we must restore pointer!
  dec( pBuf, SizeOf( DWORD ) + NumEntries * SizeOf( IPAddrRow ) );
  FreeMem( pBuf );
end;



//* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *//
procedure Get_AdaptersInfo( List: TStrings );
var
  Error,
  BufLen      : DWORD;
  P             : Pointer;
  AdapterInfo   : PTIP_ADAPTER_INFO;
  Descr,
  LocalIP,
  GatewayIP,
  DHCPIP      : string;
begin
  if not Assigned( List ) then EXIT;
  List.Clear;
  BufLen := SizeOf( AdapterInfo^ );
  New( AdapterInfo );
  Error := GetAdaptersInfo( AdapterInfo, @BufLen );
  P := AdapterInfo;
  if Error = NO_ERROR then
  begin
    while P <> nil do
      with TIP_ADAPTER_INFO(P^) do
      begin
        SetLength( Descr, SizeOf( Description ) );
        Descr := Trim( string( Description ) );
        //
        if IPAddressList.IpAddress[1] <> #0 then
          LocalIP := IPAddressList.IpAddress
        else
          LocalIP := NULL_IP;
        //
        if GateWayList.IPAddress[1] <> #0 then
          GateWayIP := GatewayList.IPAddress
        else
          GateWayIP := NULL_IP;
        //
        if DHCPServer.IPAddress[1] <> #0 then
          DHCPIP := DHCPServer.IPAddress
        else
          DHCPIP := NULL_IP;

        List.Add( Descr );
        List.Add( Format(
          '%8.8x|%6s|%16s|%2d|%16s|%16s|%16s',
          [Index, AdaptTypes[aType],
          MacAddr2Str( TMacAddress( Address ), AddressLength ),
            DHCPEnabled, LocalIP, GatewayIP, DHCPIP] )
            );
        List.Add( '  ' );
        P := Next;  //  TIP_ADAPTER_INFO(P^).Next  points to next entry
      end // with
    end // while
  else
    List.Add( SysErrorMessage( Error ) );
  Dispose( AdapterInfo );
end;




//-----------------------------------------------------------------------------
function Get_RTTAndHopCount( IPAddr: DWORD; MaxHops: Longint; var RTT: Longint;
  var HopCount: Longint ): integer;
begin
  if not GetRTTAndHopCount( IPAddr, @HopCount, MaxHops, @RTT ) then
  begin
    Result := GetLastError;
    RTT := -1; // Destination unreachable, BAD_HOST_NAME,etc...
    HopCount := -1;
  end
  else
    Result := NO_ERROR;
end;

//-----------------------------------------------------------------------------

procedure Get_ARPTable( List: TStrings );
var
  IPNetRow      : TMibIPNetRow;
  TableSize     : DWORD;
  NumEntries    : DWORD;
  ErrorCode     : DWORD;
  i             : integer;
  pBuf          : PChar;
begin
  if not Assigned( List ) then EXIT;
  List.Clear;
  // first call: get table length
  TableSize := 0;
  ErrorCode := GetIPNetTable( PTMIBIpNetTable( pBuf ), @TableSize, false );
  //
  if ErrorCode = ERROR_NO_DATA then
  begin
    List.Add( ' ARP-cache empty.' );
    EXIT;
  end;
  // get table
  GetMem( pBuf, TableSize );
  ErrorCode := GetIpNetTable( PTMIBIPNetTable( pBuf ), @TableSize, false );
  if ErrorCode = NO_ERROR then
  begin
    NumEntries := PTMIBIPNetTable( pBuf )^.dwNumEntries;
    if NumEntries > 0 then
    begin
      inc( pBuf, SizeOf( DWORD ) ); // get past table size
      for i := 1 to NumEntries do
      begin
        IPNetRow := PTMIBIPNetRow( PBuf )^;
        with IPNetRow do
          List.Add( Format( '%8x | %12s | %16s| %10s',
                           [dwIndex, MacAddr2Str( bPhysAddr, dwPhysAddrLen ),
                           IPAddr2Str( dwAddr ), ARPEntryType[dwType]
                           ]));
        inc( pBuf, SizeOf( IPNetRow ) );
      end;
    end
    else
      List.Add( ' ARP-cache empty.' );
  end
  else
    List.Add( SysErrorMessage( ErrorCode ) );

  // we _must_ restore pointer!
  dec( pBuf, SizeOf( DWORD ) + NumEntries * SizeOf( IPNetRow ) );
  FreeMem( pBuf );

end;


//------------------------------------------------------------------------------
procedure Get_TCPTable( List: TStrings );
var
  TCPRow        : TMIBTCPRow;
  i,
    NumEntries  : integer;
  TableSize     : DWORD;
  ErrorCode     : DWORD;
  DestIP        : string;
  pBuf          : PChar;
begin
  if not Assigned( List ) then EXIT;
  List.Clear;
  RecentIPs.Clear;

  TableSize := 0;
  ErrorCode := GetTCPTable( PTMIBTCPTable( pBuf ), @TableSize, true );
  if Errorcode <> ERROR_INSUFFICIENT_BUFFER then
    EXIT;


  GetMem( pBuf, TableSize );
  // get table
  ErrorCode := GetTCPTable( PTMIBTCPTable( pBuf ), @TableSize, true );
  if ErrorCode = NO_ERROR then
  begin

    NumEntries := PTMIBTCPTable( pBuf )^.dwNumEntries;
    if NumEntries > 0 then
    begin
      inc( pBuf, SizeOf( DWORD ) ); // get past table size
      for i := 1 to NumEntries do
      begin
        TCPRow := PTMIBTCPRow( pBuf )^; // get next record
        with TCPRow do
        begin
          if dwRemoteAddr = 0 then
            dwRemotePort := 0;
          DestIP := IPAddr2Str( dwRemoteAddr );
          List.Add(
            Format( '%15s : %-7s|%15s : %-7s| %-16s',
            [IpAddr2Str( dwLocalAddr ),
            Port2Svc( Port2Wrd( dwLocalPort ) ),
              DestIP,
              Port2Svc( Port2Wrd( dwRemotePort ) ),
              TCPConnState[dwState]
              ] ) );
         //
            if (not ( dwRemoteAddr = 0 ))
            and ( RecentIps.IndexOf(DestIP) = -1 ) then
               RecentIPs.Add( DestIP );
        end;
        inc( pBuf, SizeOf( TMIBTCPRow ) );
      end;
    end;
  end
  else
    List.Add( SyserrorMessage( ErrorCode ) );
  dec( pBuf, SizeOf( DWORD ) + NumEntries * SizeOf( TMibTCPRow ) );
  FreeMem( pBuf );
end;


//------------------------------------------------------------------------------
procedure Get_OpenConnections( List: TList );
var
  TCPRow        : TMIBTCPRow;
  i,
    NumEntries  : integer;
  TableSize     : DWORD;
  ErrorCode     : DWORD;
  DestIP        : string;
  pBuf          : PChar;
  CStat         : PTTcpConnStatus;
begin
  if not Assigned( List ) then EXIT;
  List.Clear;

  TableSize := 0;
  ErrorCode := GetTCPTable( PTMIBTCPTable( pBuf ), @TableSize, true );
  if Errorcode <> ERROR_INSUFFICIENT_BUFFER then
    EXIT;


  GetMem( pBuf, TableSize );
  // get table
  ErrorCode := GetTCPTable( PTMIBTCPTable( pBuf ), @TableSize, true );
  if ErrorCode = NO_ERROR then
  begin
    NumEntries := PTMIBTCPTable( pBuf )^.dwNumEntries;
    if NumEntries > 0 then
    begin
      inc( pBuf, SizeOf( DWORD ) ); // get past table size
      for i := 1 to NumEntries do
      begin
        TCPRow := PTMIBTCPRow( pBuf )^; // get next record
        with TCPRow do
          if dwState in [2,5] then   // only listening, established
          begin
            New( CStat );
            CStat^.LocalIP   := IPAddr2Str( dwLocalAddr );
            CStat^.LocalPort := Port2Svc( Port2Wrd( dwLocalPort ));
            if dwRemoteAddr <> 0 then
            begin
              CStat^.RemoteIP     := IPAddr2Str( dwRemoteAddr );
              CStat^.RemotePort   := Port2Svc( Port2Wrd( dwRemotePort ));
            end
            else begin
              CStat^.RemoteIP   := '...';
              CStat^.RemotePort := '...';
            end;
            CStat^.Status       := TCPConnState[dwState];
            List.Add( CStat );
          end;
        inc( pBuf, SizeOf( TMIBTCPRow ) );
      end;
    end;
  end;
  dec( pBuf, SizeOf( DWORD ) + NumEntries * SizeOf( TMibTCPRow ) );
  FreeMem( pBuf );
end;



//------------------------------------------------------------------------------
procedure Get_TCPStatistics( List: TStrings );
var
  TCPStats      : TMibTCPStats;
  ErrorCode     : DWORD;
begin
  if not Assigned( List ) then EXIT;
  List.Clear;
  ErrorCode := GetTCPStatistics( @TCPStats );
  if ErrorCode = NO_ERROR then
    with TCPStats do
    begin
      List.Add( 'Retransmission algorithm :' + TCPToAlgo[dwRTOAlgorithm] );
      List.Add( 'Minimum Time-Out         :' + IntToStr( dwRTOMin ) + ' ms' );
      List.Add( 'Maximum Time-Out         :' + IntToStr( dwRTOMax ) + ' ms' );
      List.Add( 'Maximum Pend.Connections :' + IntToStr( dwRTOAlgorithm ) );
      List.Add( 'Active Opens             :' + IntToStr( dwActiveOpens ) );
      List.Add( 'Passive Opens            :' + IntToStr( dwPassiveOpens ) );
      List.Add( 'Failed Open Attempts     :' + IntToStr( dwAttemptFails ) );
      List.Add( 'Established conn. Reset  :' + IntToStr( dwEstabResets ) );
      List.Add( 'Current Established Conn.:' + IntToStr( dwCurrEstab ) );
      List.Add( 'Segments Received        :' + IntToStr( dwInSegs ) );
      List.Add( 'Segments Sent            :' + IntToStr( dwOutSegs ) );
      List.Add( 'Segments Retransmitted   :' + IntToStr( dwReTransSegs ) );
      List.Add( 'Incoming Errors          :' + IntToStr( dwInErrs ) );
      List.Add( 'Outgoing Resets          :' + IntToStr( dwOutRsts ) );
      List.Add( 'Cumulative Connections   :' + IntToStr( dwNumConns ) );
    end
  else
    List.Add( SyserrorMessage( ErrorCode ) );

end;

//------------------------------------------------------------------------------
procedure Get_UDPTable( List: TStrings );
var
  UDPRow        : TMIBUDPRow;
  i,
    NumEntries  : integer;
  TableSize     : DWORD;
  ErrorCode     : DWORD;
  pBuf          : PChar;
begin
  if not Assigned( List ) then EXIT;
  List.Clear;

  // first call : get size of table
  TableSize := 0;
  ErrorCode := GetUDPTable( PTMIBUDPTable( pBuf ), @TableSize, true );
  if Errorcode <> ERROR_INSUFFICIENT_BUFFER then
    EXIT;

  // get required size of memory, call again
  GetMem( pBuf, TableSize );

  // get table
  ErrorCode := GetUDPTable( PTMIBUDPTable( pBuf ), @TableSize, true );
  if ErrorCode = NO_ERROR then
  begin
    NumEntries := PTMIBUDPTable( pBuf )^.dwNumEntries;
    if NumEntries > 0 then
    begin
      inc( pBuf, SizeOf( DWORD ) ); // get past table size
      for i := 1 to NumEntries do
      begin
        UDPRow := PTMIBUDPRow( pBuf )^; // get next record
        with UDPRow do
          List.Add( Format( '%15s : %-6s',
            [IpAddr2Str( dwLocalAddr ),
            Port2Svc( Port2Wrd( dwLocalPort ) )
              ] ) );
        inc( pBuf, SizeOf( TMIBUDPRow ) );
      end;
    end
    else
      List.Add( 'no entries.' );
  end
  else
    List.Add( SyserrorMessage( ErrorCode ) );
  dec( pBuf, SizeOf( DWORD ) + NumEntries * SizeOf( TMibUDPRow ) );
  FreeMem( pBuf );
end;

//------------------------------------------------------------------------------
procedure Get_IPAddrTable( List: TStrings );
var
  IPAddrRow     : TMibIPAddrRow;
  TableSize     : DWORD;
  ErrorCode     : DWORD;
  i             : integer;
  pBuf          : PChar;
  NumEntries    : DWORD;
begin
  if not Assigned( List ) then EXIT;
  List.Clear;
  TableSize := 0; ;
  // first call: get table length
  ErrorCode := GetIpAddrTable( PTMibIPAddrTable( pBuf ), @TableSize, true );
  if Errorcode <> ERROR_INSUFFICIENT_BUFFER then
    EXIT;

  GetMem( pBuf, TableSize );
  // get table
  ErrorCode := GetIpAddrTable( PTMibIPAddrTable( pBuf ), @TableSize, true );
  if ErrorCode = NO_ERROR then
  begin
    NumEntries := PTMibIPAddrTable( pBuf )^.dwNumEntries;
    if NumEntries > 0 then
    begin
      inc( pBuf, SizeOf( DWORD ) );
      for i := 1 to NumEntries do
      begin
        IPAddrRow := PTMIBIPAddrRow( pBuf )^;
        with IPAddrRow do
          List.Add( Format( '%8.8x|%15s|%15s|%15s|%8.8d',
            [dwIndex,
            IPAddr2Str( dwAddr ),
              IPAddr2Str( dwMask ),
              IPAddr2Str( dwBCastAddr ),
              dwReasmSize
              ] ) );
        inc( pBuf, SizeOf( TMIBIPAddrRow ) );
      end;
    end
    else
      List.Add( 'no entries.' );
  end
  else
    List.Add( SysErrorMessage( ErrorCode ) );

  // we must restore pointer!
  dec( pBuf, SizeOf( DWORD ) + NumEntries * SizeOf( IPAddrRow ) );
  FreeMem( pBuf );
end;



procedure Get_IPForwardTable( List: TStrings );
var
  IPForwRow     : TMibIPForwardRow;
  TableSize     : DWORD;
  ErrorCode     : DWORD;
  i             : integer;
  pBuf          : PChar;
  NumEntries    : DWORD;
begin
  if not Assigned( List ) then EXIT;
  List.Clear;
  TableSize := 0;

  // first call: get table length
  ErrorCode := GetIpForwardTable( PTMibIPForwardTable( pBuf ), @TableSize, true
    );
  if Errorcode <> ERROR_INSUFFICIENT_BUFFER then
    EXIT;

  // get table
  GetMem( pBuf, TableSize );
  ErrorCode := GetIpForwardTable( PTMibIPForwardTable( pBuf ), @TableSize, true
    );
  if ErrorCode = NO_ERROR then
  begin
    NumEntries := PTMibIPForwardTable( pBuf )^.dwNumEntries;
    if NumEntries > 0 then
    begin
      inc( pBuf, SizeOf( DWORD ) );
      for i := 1 to NumEntries do
      begin
        IPForwRow := PTMibIPForwardRow( pBuf )^;
        with IPForwRow do
          List.Add( Format(
            '%15s|%15s|%15s|%8.8x|%7s|   %5.5d|    %7s|        %2.2d',
            [IPAddr2Str( dwForwardDest ),
            IPAddr2Str( dwForwardMask ),
              IPAddr2Str( dwForwardNextHop ),
              dwForwardIFIndex,
              IPForwTypes[dwForwardType],
              dwForwardNextHopAS,
              IPForwProtos[dwForwardProto],
              dwForwardMetric1
              ] ) );
        inc( pBuf, SizeOf( TMibIPForwardRow ) );
      end;
    end
    else
      List.Add( 'no entries.' );
  end
  else
    List.Add( SysErrorMessage( ErrorCode ) );
  dec( pBuf, SizeOf( DWORD ) + NumEntries * SizeOf( TMibIPForwardRow ) );
  FreeMem( pBuf );
end;

//------------------------------------------------------------------------------
procedure Get_IPStatistics( List: TStrings );
var
  IPStats       : TMibIPStats;
  ErrorCode     : integer;
begin
  if not Assigned( List ) then EXIT;
  ErrorCode := GetIPStatistics( @IPStats );
  if ErrorCode = NO_ERROR then
  begin
    List.Clear;
    with IPStats do
    begin
      if dwForwarding = 1 then
        List.add( 'Forwarding Enabled      : ' + 'Yes' )
      else
        List.add( 'Forwarding Enabled      : ' + 'No' );
      List.add( 'Default TTL             : ' + inttostr( dwDefaultTTL ) );
      List.add( 'Datagrams Received      : ' + inttostr( dwInReceives ) );
      List.add( 'Header Errors     (In)  : ' + inttostr( dwInHdrErrors ) );
      List.add( 'Address Errors    (In)  : ' + inttostr( dwInAddrErrors ) );
      List.add( 'Unknown Protocols (In)  : ' + inttostr( dwInUnknownProtos ) );
      List.add( 'Datagrams Discarded     : ' + inttostr( dwInDiscards ) );
      List.add( 'Datagrams Delivered     : ' + inttostr( dwInDelivers ) );
      List.add( 'Requests Out            : ' + inttostr( dwOutRequests ) );
      List.add( 'Routings Discarded      : ' + inttostr( dwRoutingDiscards ) );
      List.add( 'No Routes          (Out): ' + inttostr( dwOutNoRoutes ) );
      List.add( 'Reassemble TimeOuts     : ' + inttostr( dwReasmTimeOut ) );
      List.add( 'Reassemble Requests     : ' + inttostr( dwReasmReqds ) );
      List.add( 'Succesfull Reassemblies : ' + inttostr( dwReasmOKs ) );
      List.add( 'Failed Reassemblies     : ' + inttostr( dwReasmFails ) );
      List.add( 'Succesful Fragmentations: ' + inttostr( dwFragOKs ) );
      List.add( 'Failed Fragmentations   : ' + inttostr( dwFragFails ) );
      List.add( 'Datagrams Fragmented    : ' + inttostr( dwFRagCreates ) );
      List.add( 'Number of Interfaces    : ' + inttostr( dwNumIf ) );
      List.add( 'Number of IP-addresses  : ' + inttostr( dwNumAddr ) );
      List.add( 'Routes in RoutingTable  : ' + inttostr( dwNumRoutes ) );
    end;
  end
  else
    List.Add( SysErrorMessage( ErrorCode ) );
end;

//------------------------------------------------------------------------------
procedure Get_UdpStatistics( List: TStrings );
var
  UdpStats      : TMibUDPStats;
  ErrorCode     : integer;
begin
  if not Assigned( List ) then EXIT;
  ErrorCode := GetUDPStatistics( @UdpStats );
  if ErrorCode = NO_ERROR then
  begin
    List.Clear;
    with UDPStats do
    begin
      List.add( 'Datagrams (In)    : ' + inttostr( dwInDatagrams ) );
      List.add( 'Datagrams (Out)   : ' + inttostr( dwOutDatagrams ) );
      List.add( 'No Ports          : ' + inttostr( dwNoPorts ) );
      List.add( 'Errors    (In)    : ' + inttostr( dwInErrors ) );
      List.add( 'UDP Listen Ports  : ' + inttostr( dwNumAddrs ) );
    end;
  end
  else
    List.Add( SysErrorMessage( ErrorCode ) );
end;

//------------------------------------------------------------------------------
procedure Get_ICMPStats( ICMPIn, ICMPOut: TStrings );
var
  ErrorCode     : DWORD;
  ICMPStats     : PTMibICMPInfo;
begin
  if ( ICMPIn = nil ) or ( ICMPOut = nil ) then EXIT;
  ICMPIn.Clear;
  ICMPOut.Clear;
  New( ICMPStats );
  ErrorCode := GetICMPStatistics( ICMPStats );
  if ErrorCode = NO_ERROR then
  begin
    with ICMPStats.InStats do
    begin
      ICMPIn.Add( 'Messages received    : ' + IntToStr( dwMsgs ) );
      ICMPIn.Add( 'Errors               : ' + IntToStr( dwErrors ) );
      ICMPIn.Add( 'Dest. Unreachable    : ' + IntToStr( dwDestUnreachs ) );
      ICMPIn.Add( 'Time Exceeded        : ' + IntToStr( dwTimeEcxcds ) );
      ICMPIn.Add( 'Param. Problems      : ' + IntToStr( dwParmProbs ) );
      ICMPIn.Add( 'Source Quench        : ' + IntToStr( dwSrcQuenchs ) );
      ICMPIn.Add( 'Redirects            : ' + IntToStr( dwRedirects ) );
      ICMPIn.Add( 'Echo Requests        : ' + IntToStr( dwEchos ) );
      ICMPIn.Add( 'Echo Replies         : ' + IntToStr( dwEchoReps ) );
      ICMPIn.Add( 'Timestamp Requests   : ' + IntToStr( dwTimeStamps ) );
      ICMPIn.Add( 'Timestamp Replies    : ' + IntToStr( dwTimeStampReps ) );

      ICMPIn.Add( 'Addr. Masks Requests : ' + IntToStr( dwAddrMasks ) );
      ICMPIn.Add( 'Addr. Mask Replies   : ' + IntToStr( dwAddrReps ) );
    end;
     //
    with ICMPStats^.OutStats do
    begin
      ICMPOut.Add( 'Messages sent        : ' + IntToStr( dwMsgs ) );
      ICMPOut.Add( 'Errors               : ' + IntToStr( dwErrors ) );
      ICMPOut.Add( 'Dest. Unreachable    : ' + IntToStr( dwDestUnreachs ) );
      ICMPOut.Add( 'Time Exceeded        : ' + IntToStr( dwTimeEcxcds ) );
      ICMPOut.Add( 'Param. Problems      : ' + IntToStr( dwParmProbs ) );
      ICMPOut.Add( 'Source Quench        : ' + IntToStr( dwSrcQuenchs ) );
      ICMPOut.Add( 'Redirects            : ' + IntToStr( dwRedirects ) );
      ICMPOut.Add( 'Echo Requests        : ' + IntToStr( dwEchos ) );
      ICMPOut.Add( 'Echo Replies         : ' + IntToStr( dwEchoReps ) );
      ICMPOut.Add( 'Timestamp Requests   : ' + IntToStr( dwTimeStamps ) );
      ICMPOut.Add( 'Timestamp Replies    : ' + IntToStr( dwTimeStampReps ) );
      ICMPOut.Add( 'Addr. Masks Requests : ' + IntToStr( dwAddrMasks ) );
      ICMPOut.Add( 'Addr. Mask Replies   : ' + IntToStr( dwAddrReps ) );
    end;
  end
  else
    IcmpIn.Add( SysErrorMessage( ErrorCode ) );
  Dispose( ICMPStats );
end;

//------------------------------------------------------------------------------
procedure Get_RecentDestIPs( List: TStrings );
begin
  if Assigned( List ) then
    List.Assign( RecentIPs )
end;

initialization

  RecentIPs := TStringList.Create;

finalization

  RecentIPs.Free;

end.


