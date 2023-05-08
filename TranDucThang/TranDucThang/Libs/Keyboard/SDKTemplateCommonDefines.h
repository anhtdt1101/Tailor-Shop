//
//  SDKManagerCommonDefines.h
//  SDKTemplateExample
//
//  Created by thebv on 25/05/2021.
//

#define IOS_VERSION ([[[UIDevice currentDevice] systemVersion] floatValue])

#define IS_LANDSCAPE UIInterfaceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation])
#define IS_DEVICE_LANDSCAPE UIDeviceOrientationIsLandscape([[UIDevice currentDevice] orientation])

#define SCREEN_WIDTH (IOS_VERSION >= 8.0 ? [[UIScreen mainScreen] bounds].size.width : (IS_LANDSCAPE ? [[UIScreen mainScreen] bounds].size.height : [[UIScreen mainScreen] bounds].size.width))
#define DEVICE_WIDTH (IOS_VERSION >= 8.0 ? (IS_LANDSCAPE ? [[UIScreen mainScreen] bounds].size.height : [[UIScreen mainScreen] bounds].size.width) : [[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT (IOS_VERSION >= 8.0 ? [[UIScreen mainScreen] bounds].size.height : (IS_LANDSCAPE ? [[UIScreen mainScreen] bounds].size.width : [[UIScreen mainScreen] bounds].size.height))
#define DEVICE_HEIGHT (IOS_VERSION >= 8.0 ? (IS_LANDSCAPE ? [[UIScreen mainScreen] bounds].size.width : [[UIScreen mainScreen] bounds].size.height) : [[UIScreen mainScreen] bounds].size.height)

#define img(name) [SDKTemplateBundleLocator imageNamed:name]

#define font(value) [UIFont fontWithName:SDKTemplateStyle.sharedInstance.fontNameNormal size:value]
#define fontM(value) [UIFont fontWithName:SDKTemplateStyle.sharedInstance.fontNameMedium size:value]
#define fontB(value) [UIFont fontWithName:SDKTemplateStyle.sharedInstance.fontNameBold size:value]

#define colorWithHex(value) [SDKBIDVTemplateUtils colorWithHex:value]
#define colorWithHexString(value) [SDKBIDVTemplateUtils colorWithHexString:value]
#define colorWithRGB(r, g, b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
#define colorWithRGBA(r, g, b, a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a/1.0]

#define PreferredVarForDevices(varFor55Inch, varFor47Inch, varFor40Inch, varFor35Inch) (IS_35INCH_SCREEN ? varFor35Inch : (IS_40INCH_SCREEN ? varFor40Inch : (IS_47INCH_SCREEN ? varFor47Inch : varFor55Inch)))
#define PreferredVarForUniversalDevices(varForPad, varFor55Inch, varFor47Inch, varFor40Inch, varFor35Inch) (IS_IPAD ? varForPad :(IS_55INCH_SCREEN ? varFor55Inch : (IS_47INCH_SCREEN ? varFor47Inch : (IS_40INCH_SCREEN ? varFor40Inch : varFor35Inch))))
#define WEAK __weak typeof(self)

//color
#define colorText colorWithRGB(36, 37, 38)
#define colorLine colorWithRGB(239, 239, 239)
#define colorGray1 colorWithHex(0x4a4a4a)
#define colorGray2 colorWithHex(0x717171)
#define colorGray3 colorWithHex(0xb6c3cf)
#define colorGray4 colorWithHex(0xc9c9c9)
#define colorGray5 colorWithHex(0xdfdfdf)
#define colorGray6 colorWithHex(0xecebeb)
#define colorGray7 colorWithHex(0xf2f5f7)
#define colorGray8 colorWithHex(0xededef)

#define TEXT_CHANGE_INPUT_VALUE @"TEXT_CHANGE_INPUT_VALUE"
#define TEXT_DONE_INPUT_VALUE @"TEXT_DONE_INPUT_VALUE"
#define TEXT_INPUT_SIZE_CHANGE @"TEXT_INPUT_SIZE_CHANGE"
#define BUTTON_VALUE_SIZE_CHANGE @"BUTTON_VALUE_SIZE_CHANGE"

#define margin_X 16.0f
#define margin_Y 16.0f

#define s_Height_Input_Value 76.0f
#define s_Button_Height 44.0f
#define s_Height_Button 48.0f
#define s_Height_Item 44.0f

#define s_Bank_Color  [SDKBIDVTemplateUtils colorWithHexString:@"214094"]
#define s_Background_Color [SDKBIDVTemplateUtils colorWithHexString:@"#f3f3f3"]

#define screenWidth [[UIScreen mainScreen] bounds].size.width
#define screenHeight [[UIScreen mainScreen] bounds].size.height

#define s_Height_Tabbar [VBConstant TABBAR_HEIGHT]
#define s_Height_Header [VBConstant HEADER_HEIGHT]
#define s_Height_StatusBar [VBConstant HEADER_STATUSBAR]
#define s_Height_Footer [VBConstant footer_iphoneX]


#define text_BlackColor [SDKBIDVTemplateUtils colorWithHexString:@"#242526"]
#define text_Color [SDKBIDVTemplateUtils colorWithHexString:@"#3d4457"]
#define text_DesColor [SDKBIDVTemplateUtils colorWithHexString:@"#8f949b"]
#define text_PlaceHolder [SDKBIDVTemplateUtils colorWithHexString:@"#6d6d72"]
#define text_Yellow_Color [SDKBIDVTemplateUtils colorWithHexString:@"#FBCF03"]

#define seperator_Color [SDKBIDVTemplateUtils colorWithHexString:@"#f1f2f2"]
#define bg_color [UIColor colorWithRed:248/255.0f green:248/255.0f blue:248/255.0f alpha:1.0]
#define btn_color [SDKBIDVTemplateUtils colorWithHexString:@"#0266AD"]
#define btn_color_disable [SDKBIDVTemplateUtils colorWithHexString:@"#c7c7c7"]
#define lixi_yellow_color [SDKBIDVTemplateUtils colorWithHexString:@"#F7E785"]
#define lixi_red_color [SDKBIDVTemplateUtils colorWithHexString:@"#CB2122"]

//dinhpv
#define color_background [SDKBIDVTemplateUtils colorWithHexString:@"#f3f3f3"]
//#define color_bank [UIColor colorWithHex:@"#214094"]
#define color_text_black [SDKBIDVTemplateUtils colorWithHexString:@"#232626"]
#define color_bank [SDKTemplateStyle sharedInstance].colorPrimary

#define color_bank_blue [SDKTemplateStyle sharedInstance].colorPrimary
#define color_text_light [SDKBIDVTemplateUtils colorWithHexString:@"#f3f3f3"]
#define color(color_) [UIColor colorWithHex:color_]

typedef void(^callbackBIDV)(int code,id rowValue);
//typedef NS_ENUM(NSUInteger, VBKeyboardButtonStyle) {
//    VBKeyboardButtonStyleWhite,
//    VBKeyboardButtonStyleGray,
//    VBKeyboardButtonStyleDone
//};
//
typedef NS_ENUM(NSUInteger, VBHeaderType) {
    VBHeader_Gradient,
    VBHeader_White,
    VBHeader_Clear,
    VBHeader_Logo
};
enum {
    VALIDATE_OK          = 0,
    VALIDATE_EMPTY  = 1,
    VALIDATE_ERROR   = 2,
};
//enum {
//    INPUT_TYPE_BUTTON    = 0,
//    INPUT_TYPE_BUTTON_SIMPLE    = 1,
//    INPUT_TYPE_BUTTON_DATE    = 2,
//    INPUT_TYPE_NOTE    = 101,
//    INPUT_TYPE_LAST_NAME  = 501,
//
//    INPUT_TYPE_NAME  = 102,
//    INPUT_TYPE_ACCOUNT   = 103,
//    INPUT_TYPE_PHONE   = 104,
//
//    INPUT_TYPE_EMAIL   = 105,
//    INPUT_TYPE_OTP   = 106,
//    INPUT_TYPE_BILL   = 107,
//    INPUT_TYPE_MONEY    = 108,
//    INPUT_TYPE_CMND   = 109,
//    INPUT_TYPE_PASSWORD   = 111,
//
//    INPUT_TYPE_NUMBER   = 112,
//    INPUT_TYPE_ALL_FORMAT   = 114,
//    INPUT_TYPE_NUM_VNSHOP   = 115,
//    INPUT_TYPE_RATE   = 116,
//    INPUT_TYPE_MONEY_SAVING    = 117,
//    INPUT_TYPE_MONEY_INTERNATIONAL    = 118,
//    INPUT_TYPE_MONEY_TRANS_FOREIGN    = 119,
//
//    INPUT_TYPE_PHONE_ACCOUNT   = 120,
//
//    INPUT_TYPE_NAME_AUTO_UP  = 125,
//    INPUT_TYPE_CARD_NUMBER   = 126,
//    INPUT_TYPE_ACCOUNT_VN   = 127,
//    INPUT_TYPE_ACCOUNT_CARD   = 128,
//    INPUT_TYPE_ALL_ACCOUNT_BIDV   = 129,
//    INPUT_TYPE_SURNAME  = 130,
//    INPUT_TYPE_EMAIL_ADD   = 131,
//    INPUT_TYPE_EMAIL_DOT   = 132,
//    INPUT_TYPE_SEARCH_INAPP   = 133,
//    INPUT_TYPE_DEFAULTKEYBOARD   = 134,
//    INPUT_TYPE_MONEY_QLTCCN    = 135,
//    INPUT_TYPE_ACCOUNT_BIDV   = 136,
//    INPUT_TYPE_NAME_BEN  = 137,
//    INPUT_TYPE_NOTE_TRANSFER = 138,
//    INPUT_TYPE_NAME_TRANSFER  = 139,
//    INPUT_TYPE_NOTE_QR = 140,
//    INPUT_TYPE_ALL_FORMAT_QR = 141,
//    INPUT_TYPE_ALL_FORMAT_VN = 142,
//    INPUT_TYPE_PIN_RANDOM = 143,
//
//};
enum {
    BUTTON_ACTION_CANCEL    = 0,
    BUTTON_ACTION_OK    = 1,
};
enum {
    TYPE_LISTVIEW_SIMPLE = 0,
    TYPE_LISTVIEW_ACCOUNT = 1,
    TYPE_LISTVIEW_SERVICES = 2,
    TYPE_LISTVIEW_BENE = 3,
    TYPE_LISTVIEW_BENE_BILL = 4,
    TYPE_LISTVIEW_IMAGE_TITLE = 5,
    TYPE_LISTVIEW_BANKS = 6,
    TYPE_LISTVIEW_TITLE_VALUE = 7,
    TYPE_LISTVIEW_BRANCH = 8,
    TYPE_LISTVIEW_AVATAR = 9,


};
