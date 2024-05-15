//
//  AppConstants.swift
//  Voronka
//
//  Created by Danil Shvetsov on 11.02.2023.
//

import UIKit

final class AppConstants {
    
    final class Design {
        
        final class Padding {
            
            class var Small: Int {
                10
            }
            
            class var Medium: Int {
                12
            }
            
            class var Large: Int {
                16
            }
            
            class var UltraLarge: Int {
                23
            }
            
        }
        
        final class Size {
            
            class var UltraSmall: CGFloat {
                4.0
            }
            
            class var Small: CGFloat {
                20.0
            }
            
            class var Medium: CGFloat {
                33.0
            }
            
            class var Large: CGFloat {
                70.0
            }
            
        }
        
        final class CornerRadius {
            
            class var Small: CGFloat {
                10.0
            }
            
            class var Medium: CGFloat {
                15.0
            }
            
            class var Large: CGFloat {
                20.0
            }
            
        }
        
        final class Color {
            
            final class Primary {
                
                class var Black: UIColor {
                    UIColor(rgb: 0x090A0C)
                }
                
                class var White: UIColor {
                    UIColor.white
                }
                
                class var Green: UIColor {
                    UIColor(rgb: 0x0CBD68)
                }
                
                class var Red: UIColor {
                    UIColor(rgb: 0xAC4444)
                }
                
                class var Blue: UIColor {
                    UIColor(rgb: 0x0A84FF)
                }
                
            }
            
            final class Secondary {
                
                class var White: UIColor {
                    UIColor(rgb: 0xF2EDEA)
                }
                
                class var BorderWhite: UIColor {
                    UIColor(rgb: 0xC9C9C9)
                }
                
                class var Blue: UIColor {
                    UIColor(rgb: 0x0A71FF)
                }
                
                class var UnderlineLightGray: UIColor {
                    UIColor(rgb: 0xC6C6C8)
                }
                
                class var MediumGray: UIColor {
                    UIColor(rgb: 0x7D7D7D)
                }
                
            }
            
            final class GrayScale {
                
                class var UltraLight: UIColor {
                    UIColor(rgb: 0x8A8A8E)
                }
                
                class var Light: UIColor {
                    UIColor(rgb: 0x5D5C5A)
                }
                
                class var Medium: UIColor {
                    UIColor(rgb: 0x565656)
                }
                
                class var Dark: UIColor {
                    UIColor(rgb: 0x2E2E2E)
                }
        
                class var UltraDark: UIColor {
                    UIColor(rgb: 0x1D1D1D)
                }
                
            }
            
        }
        
        final class Image {
            
            class var BackButton: UIImage {
                UIImage(systemName: "chevron.backward") ?? UIImage()
            }
            
            class var DownArrow: UIImage {
                UIImage(systemName: "chevron.down") ?? UIImage()
            }
            
            class var BorderedCross: UIImage {
                UIImage(systemName: "multiply.circle") ?? UIImage()
            }
            
            class var UpArrow: UIImage {
                UIImage(systemName: "arrow.up") ?? UIImage()
            }
            
            class var SampleAvatar: UIImage {
                 UIImage(named: "Швецов_Данил")!
            }
            
        }
        
        final class Font {
            
            final class Primary {
                
                class func thin(withSize size: CGFloat) -> UIFont {
                    getCustomFont(withName: "RFDewiExtended-Thin", size: size)
                }
                
                class func regular(withSize size: CGFloat) -> UIFont {
                    getCustomFont(withName: "RFDewiExtended-Regular", size: size)
                }
                
                class func bold(withSize size: CGFloat) -> UIFont {
                    getCustomFont(withName: "RFDewiExtended-Bold", size: size)
                }
                
            }
            
            final class Secondary {
                
                class func regular(withSize size: CGFloat) -> UIFont {
                    getCustomFont(withName: "SF-Pro-Display-Regular", size: size)
                }
                
                class func medium(withSize size: CGFloat) -> UIFont {
                    getCustomFont(withName: "Raleway-Medium", size: size)
                }
                
            }
            
            private class func getCustomFont(withName name: String, size: CGFloat) -> UIFont {
                guard let font = UIFont(name: name, size: size) else {
                    return UIFont.systemFont(ofSize: size)
                }
                return font
            }
        }
        
    }
    
    final class Content {
        
        class var VoronkaRoundGIFName: String {
            "voronkaRound"
        }
        
        class var FindCommunityBackgroundGIFName: String {
            "find-community"
        }
        
        class var EventsViewedGIFName: String {
            "end_gif"
        }
        
    }
    
    final class API {
        
        class var LocalURL: String {
            "http://127.0.0.1:8080"
        }
        
        class var BaseURL: String {
            "http://158.160.19.67:8080"
        }
        
        class var GetOrganizerInfo: String {
            "/organizers/get/"
        }
        
    }
    
    final class UserDefaultsKeys {
        
        class var Registered: String {
            "registered"
        }
        
        class var UserId: String {
            "userId"
        }
        
        class var Tags: String {
            "tags"
        }
        
    }
    
}
