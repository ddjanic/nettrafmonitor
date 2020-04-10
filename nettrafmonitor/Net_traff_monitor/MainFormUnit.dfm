object MainForm: TMainForm
  Left = 451
  Top = 230
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Network Traffic Monitor'
  ClientHeight = 381
  ClientWidth = 491
  Color = clBtnFace
  ParentFont = True
  Icon.Data = {
    0000010001002020040000000000E80200001600000028000000200000004000
    0000010004000000000000020000000000000000000000000000000000000000
    000000008000008000000080800080000000800080008080000080808000C0C0
    C0000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF000000
    0000000000000000770000000000000000000000000000840770000000000000
    0000000000000084407700000000000000000000008000844407700000000000
    00000000008000844440770000000000000000000080F8844444077000000000
    000000000087F884444440770000000000000000008744844444407770000000
    00000000008444844444407000000000000000000084F8844444400000000000
    000000000087F888444440000000000000000000008788CCC444400000000000
    000000000088CCCCCC4440000000000000000077000CCCCCCCC4400000000000
    000084077000CCCCCCCC4000000000000000844077000CCCCCCCC00000000000
    80008444077000CCCCC0000000000000800084444077000CC000000000000000
    80F8844444077000000000000000000087F88444444077000000000000000000
    8744844444407700000000000000000084448444444000000000000000000000
    84F8844444400000000070000000000087F88844444000000000077000000000
    8788CCC444400000000007770000000088CCCCCC444000000000007F70000000
    0CCCCCCCC440000000000007F000000000CCCCCCCC4000000000000000000000
    000CCCCCCCC0000000000000000000000000CCCCC00000000000000000000000
    00000CC00000000000000000000000000000000000000000000000000000FFFF
    C3FFFFFF01FFFFFC00FFFFF8007FFFF8003FFFF8001FFFF8000FFFF80007FFF8
    001FFFF8003FFFF8003FFFF8003FFFF8003FFF0C001FFC06000FF0030007E001
    8067E000C1C7E000670FE0003C3FE00030FFE000C07FE0000E3FE0003F1FE000
    FF8FE000FFC7F000FFE7F800FFFFFC00FFFFFE01FFFFFF07FFFFFF9FFFFF}
  OldCreateOrder = True
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object pnlMain: TPanel
    Left = 0
    Top = 0
    Width = 491
    Height = 335
    Align = alClient
    BevelOuter = bvNone
    BorderWidth = 5
    ParentColor = True
    TabOrder = 0
    object pc: TPageControl
      Left = 5
      Top = 5
      Width = 481
      Height = 325
      ActivePage = tsTraffic
      Align = alClient
      TabOrder = 0
      OnChange = pcChange
      object tsTraffic: TTabSheet
        Caption = #1052#1086#1085#1080#1090#1086#1088' '#1090#1088#1072#1092#1092#1080#1082#1072
        object TrafficTabs: TTabSet
          Left = 0
          Top = 276
          Width = 473
          Height = 21
          Align = alBottom
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          SoftTop = True
          Tabs.Strings = (
            '1'
            '2'
            '3')
          TabIndex = 0
          OnChange = TrafficTabsChange
        end
        object GroupBox: TGroupBox
          Left = 0
          Top = 0
          Width = 473
          Height = 276
          Align = alClient
          Enabled = False
          TabOrder = 1
          DesignSize = (
            473
            276)
          object ledAdapterDescription: TLabeledEdit
            Left = 8
            Top = 32
            Width = 272
            Height = 19
            Anchors = [akLeft, akTop, akRight]
            Color = clCream
            Ctl3D = False
            EditLabel.Width = 101
            EditLabel.Height = 13
            EditLabel.Caption = #1054#1087#1080#1089#1072#1085#1080#1077' '#1072#1076#1072#1087#1090#1077#1088#1072
            ParentCtl3D = False
            ReadOnly = True
            TabOrder = 0
            OnChange = ledAdapterDescriptionChange
          end
          object ledMACAddress: TLabeledEdit
            Left = 286
            Top = 32
            Width = 103
            Height = 19
            Anchors = [akTop, akRight]
            Color = clCream
            Ctl3D = False
            EditLabel.Width = 55
            EditLabel.Height = 13
            EditLabel.Caption = 'MAC '#1072#1076#1088#1077#1089
            ParentCtl3D = False
            ReadOnly = True
            TabOrder = 1
          end
          object gbIN: TGroupBox
            Left = 8
            Top = 124
            Width = 457
            Height = 61
            Caption = #1042#1093#1086#1076#1103#1097#1072#1103' ('#1079#1072#1082#1072#1095#1082#1072')'
            Color = clBtnFace
            ParentColor = False
            TabOrder = 2
            object ledOctInSec: TLabeledEdit
              Left = 8
              Top = 32
              Width = 85
              Height = 19
              Color = clCream
              Ctl3D = False
              EditLabel.Width = 77
              EditLabel.Height = 13
              EditLabel.Caption = #1058#1088#1072#1092#1092#1080#1082' / '#1089#1077#1082'.'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clRed
              Font.Height = -12
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentCtl3D = False
              ParentFont = False
              ReadOnly = True
              TabOrder = 0
            end
            object ledAvgINSec: TLabeledEdit
              Left = 184
              Top = 32
              Width = 85
              Height = 19
              Color = clCream
              Ctl3D = False
              EditLabel.Width = 75
              EditLabel.Height = 13
              EditLabel.Caption = #1057#1088#1077#1076#1085#1103#1103' / '#1089#1077#1082'.'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clRed
              Font.Height = -12
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentCtl3D = False
              ParentFont = False
              ReadOnly = True
              TabOrder = 1
            end
            object ledPeakINSec: TLabeledEdit
              Left = 96
              Top = 32
              Width = 85
              Height = 19
              Color = clCream
              Ctl3D = False
              EditLabel.Width = 74
              EditLabel.Height = 13
              EditLabel.Caption = #1055#1080#1082#1086#1074#1072#1103' / '#1089#1077#1082'.'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clRed
              Font.Height = -12
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentCtl3D = False
              ParentFont = False
              ReadOnly = True
              TabOrder = 2
            end
            object ledTotalIN: TLabeledEdit
              Left = 272
              Top = 32
              Width = 65
              Height = 19
              Color = clCream
              Ctl3D = False
              EditLabel.Width = 33
              EditLabel.Height = 13
              EditLabel.Caption = #1042#1057#1045#1043#1054
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clRed
              Font.Height = -12
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentCtl3D = False
              ParentFont = False
              ReadOnly = True
              TabOrder = 3
            end
          end
          object gbOUT: TGroupBox
            Left = 8
            Top = 188
            Width = 457
            Height = 61
            Caption = #1048#1089#1093#1086#1076#1103#1097#1072#1103' ('#1086#1090#1076#1072#1095#1072')'
            TabOrder = 3
            object ledOctOUTSec: TLabeledEdit
              Left = 8
              Top = 32
              Width = 85
              Height = 19
              Color = clCream
              Ctl3D = False
              EditLabel.Width = 77
              EditLabel.Height = 13
              EditLabel.Caption = #1058#1088#1072#1092#1092#1080#1082' / '#1089#1077#1082'.'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlue
              Font.Height = -12
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentCtl3D = False
              ParentFont = False
              ReadOnly = True
              TabOrder = 0
            end
            object ledAvgOUTSec: TLabeledEdit
              Left = 184
              Top = 32
              Width = 85
              Height = 19
              Color = clCream
              Ctl3D = False
              EditLabel.Width = 75
              EditLabel.Height = 13
              EditLabel.Caption = #1057#1088#1077#1076#1085#1103#1103' / '#1089#1077#1082'.'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlue
              Font.Height = -12
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentCtl3D = False
              ParentFont = False
              ReadOnly = True
              TabOrder = 1
            end
            object ledPeakOUTSec: TLabeledEdit
              Left = 96
              Top = 32
              Width = 85
              Height = 19
              Color = clCream
              Ctl3D = False
              EditLabel.Width = 74
              EditLabel.Height = 13
              EditLabel.Caption = #1055#1080#1082#1086#1074#1072#1103' / '#1089#1077#1082'.'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlue
              Font.Height = -12
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentCtl3D = False
              ParentFont = False
              ReadOnly = True
              TabOrder = 2
            end
            object ledTotalOUT: TLabeledEdit
              Left = 272
              Top = 32
              Width = 65
              Height = 19
              Color = clCream
              Ctl3D = False
              EditLabel.Width = 33
              EditLabel.Height = 13
              EditLabel.Caption = #1042#1057#1045#1043#1054
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlue
              Font.Height = -12
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentCtl3D = False
              ParentFont = False
              ReadOnly = True
              TabOrder = 3
            end
          end
          object gbTime: TGroupBox
            Left = 8
            Top = 60
            Width = 457
            Height = 61
            Caption = #1057' '#1087#1086#1089#1083#1077#1076#1085#1077#1075#1086' '#1087#1077#1088#1077#1079#1072#1087#1091#1089#1082#1072':'
            TabOrder = 4
            object ledStartedAt: TLabeledEdit
              Left = 8
              Top = 32
              Width = 141
              Height = 19
              Color = clCream
              Ctl3D = False
              EditLabel.Width = 45
              EditLabel.Height = 13
              EditLabel.Caption = #1047#1072#1087#1091#1097#1077#1085
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clGreen
              Font.Height = -12
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentCtl3D = False
              ParentFont = False
              ReadOnly = True
              TabOrder = 0
            end
            object ledActiveFor: TLabeledEdit
              Left = 156
              Top = 32
              Width = 113
              Height = 19
              Color = clCream
              Ctl3D = False
              EditLabel.Width = 73
              EditLabel.Height = 13
              EditLabel.Caption = #1044#1083#1080#1090#1077#1083#1100#1085#1086#1089#1090#1100
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clGreen
              Font.Height = -12
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentCtl3D = False
              ParentFont = False
              ReadOnly = True
              TabOrder = 1
            end
          end
          object StatusText: TStaticText
            Left = 2
            Top = 257
            Width = 469
            Height = 17
            Align = alBottom
            BevelInner = bvNone
            Caption = 'StatusText'
            Color = clCream
            ParentColor = False
            TabOrder = 5
          end
          object ledSpeed: TLabeledEdit
            Left = 393
            Top = 32
            Width = 73
            Height = 19
            Anchors = [akTop, akRight]
            Color = clCream
            Ctl3D = False
            EditLabel.Width = 48
            EditLabel.Height = 13
            EditLabel.Caption = #1057#1082#1086#1088#1086#1089#1090#1100
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentCtl3D = False
            ParentFont = False
            ReadOnly = True
            TabOrder = 6
          end
        end
      end
      object tsAbout: TTabSheet
        Caption = #1054' '#1087#1088#1086#1075#1088#1072#1084#1084#1085#1086#1084' '#1087#1088#1086#1076#1091#1082#1090#1077'...'
        object Panel3: TPanel
          Left = 0
          Top = 0
          Width = 473
          Height = 297
          Align = alClient
          BevelInner = bvRaised
          BevelOuter = bvLowered
          Color = clMedGray
          TabOrder = 0
          DesignSize = (
            473
            297)
          object ProductName: TLabel
            Left = 8
            Top = 24
            Width = 457
            Height = 57
            Alignment = taCenter
            Anchors = [akLeft, akTop, akRight]
            AutoSize = False
            Caption = 
              #1057#1080#1089#1090#1077#1084#1072' '#1084#1086#1085#1080#1090#1086#1088#1080#1085#1075#1072', '#13#10#1089#1082#1072#1085#1080#1088#1086#1074#1072#1085#1080#1103' '#1089#1077#1090#1080' '#1080' '#1085#1072#1073#1083#1102#1076#1077#1085#1080#1103' '#1079#1072' '#1089#1077#1090#1077#1074#1086#1081 +
              ' '#1072#1082#1090#1080#1074#1085#1086#1089#1090#1100#1102#13#10
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clMaroon
            Font.Height = -15
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
            IsControl = True
          end
          object Label3: TLabel
            Left = 54
            Top = 168
            Width = 366
            Height = 73
            Anchors = [akLeft, akTop, akRight]
            AutoSize = False
            Caption = 
              'Network Traffic Monitor, '#1076#1072#1083#1077#1077' "'#1087#1088#1086#1075#1088#1072#1084#1084#1085#1099#1081' '#1087#1088#1086#1076#1091#1082#1090'", '#1088#1072#1079#1088#1072#1073#1086#1090#1072#1085 +
              ' '#1074' '#1088#1072#1084#1082#1072#1093' '#1076#1080#1087#1083#1086#1084#1085#1086#1075#1086' '#1087#1088#1086#1077#1082#1090#1080#1088#1086#1074#1072#1085#1080#1103' '#1080' '#1088#1072#1079#1088#1072#1073#1086#1090#1082#1080' '#1076#1083#1103' '#1044#1043#1058#1059'.'
            WordWrap = True
          end
          object StaticText1: TStaticText
            Left = 2
            Top = 277
            Width = 469
            Height = 18
            Cursor = crHandPoint
            Hint = 'Send an email to Zarko Gajic'
            Align = alBottom
            Alignment = taCenter
            BevelInner = bvNone
            BevelKind = bkSoft
            BevelOuter = bvNone
            BorderStyle = sbsSunken
            Caption = #1056#1072#1079#1088#1072#1073#1086#1090#1082#1072' ('#1089') 2015 '#1044#1043#1058#1059
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            ParentShowHint = False
            ShowHint = True
            TabOrder = 0
            OnClick = StaticText1Click
          end
        end
      end
    end
  end
  object pnlBottom: TPanel
    Left = 0
    Top = 335
    Width = 491
    Height = 46
    Align = alBottom
    BevelInner = bvLowered
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 1
    DesignSize = (
      491
      46)
    object ExitButton: TButton
      Left = 408
      Top = 8
      Width = 76
      Height = 31
      Anchors = [akTop, akRight]
      Caption = #1042#1099#1093#1086#1076
      Default = True
      ModalResult = 1
      TabOrder = 0
      OnClick = ExitButtonClick
    end
    object UnFreezeButton: TBitBtn
      Left = 80
      Top = 6
      Width = 65
      Height = 35
      Caption = #1056#1072#1079#1084#1086#1088#1086#1079#1082#1072
      TabOrder = 1
      OnClick = UnFreezeButtonClick
    end
    object FreezeButton: TBitBtn
      Left = 8
      Top = 6
      Width = 65
      Height = 35
      Caption = #1047#1072#1084#1086#1088#1086#1079#1082#1072
      TabOrder = 2
      OnClick = FreezeButtonClick
    end
    object ClearCountersButton: TBitBtn
      Left = 152
      Top = 6
      Width = 89
      Height = 35
      Caption = #1054#1073#1085#1091#1083#1080#1090#1100' '#1089#1095#1105#1090
      TabOrder = 3
      OnClick = ClearCountersButtonClick
    end
    object RemoveInactiveButton: TBitBtn
      Left = 244
      Top = 6
      Width = 65
      Height = 35
      Caption = #1059#1076#1072#1083#1080#1090#1100
      TabOrder = 4
      OnClick = RemoveInactiveButtonClick
    end
    object cbOnTop: TCheckBox
      Left = 315
      Top = 4
      Width = 86
      Height = 37
      Caption = #1055#1086#1074#1077#1088#1093' '#1074#1089#1077#1093
      TabOrder = 5
      OnClick = cbOnTopClick
    end
  end
  object Timer: TTimer
    Enabled = False
    OnTimer = TimerTimer
    Left = 444
    Top = 293
  end
end
