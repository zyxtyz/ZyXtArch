//////////////////////////////////////////////////////
// Author: Zyxtyz                                   //
// Github Repo: https://github.com/zyxtyz/ZyXtArch  //
// Last Update: 18.12.2025 10:35:30                 //
//////////////////////////////////////////////////////

fn cava_widget(cava) {      
    return box(#{      
        orientation: "horizontal",
    }, [      
        label(#{ text: cava, class: "cava" })   
    ]);      
}  
  
fn bar(cava, wifi) {  
    return box(#{  
        orientation: "horizontal",
        space_evenly: true,
        spacing: 100,
        class: "bar",
        halign: "center",
    }, [
        left_bar(),  
        cava_widget(cava),
        right_bar(wifi)
        
    ]);  
}

fn left_bar() {
    return box(#{
        orientation: "horizontal",
        space_evenly: true,
        //spacing: 10,
        class: "left-bar",
        hexpand: true,
    },
    [
        
    ]);
}
fn right_bar(wifi) {
    return box(#{
        orientation: "horizontal",
        space_evenly: true,
        //spacing: 30,
        class: "right-bar",
        hexpand: true,

    },
    [
        wifi_widget(wifi)
    ])
}

fn wifi_widget(wifi) {
    return box(#{
        orientation: "horizontal",
    }, [
        label(#{ text: wifi, class: "wifi"})
    ]);
}
                                                                                                     
//      ______   ______   ______   ______   ______   ______   ______   ______   ______   ______   ______  
//     /_____/  /_____/  /_____/  /_____/  /_____/  /_____/  /_____/  /_____/  /_____/  /_____/  /_____/                                                                                                        
//    ___.                       .__  .__          __                                        .__  .__         
//    \_ |__ _____ _______       |  | |__| _______/  |_  ____   ____           ______   ____ |  | |  |        
//     | __ \\__  \\_  __ \      |  | |  |/  ___/\   __\/ __ \ /    \   ______ \____ \ /  _ \|  | |  |        
//     | \_\ \/ __ \|  | \/      |  |_|  |\___ \  |  | \  ___/|   |  \  /_____/ |  |_> >  <_> )  |_|  |__      
//     |___  (____  /__|         |____/__/____  > |__|  \___  >___|  /         |   __/ \____/|____/____/      
//         \/     \/                          \/            \/     \/          |__|                           
//      ______   ______   ______   ______   ______   ______   ______   ______   ______   ______   ______  
//     /_____/  /_____/  /_____/  /_____/  /_____/  /_____/  /_____/  /_____/  /_____/  /_____/  /_____/                                                                                                         
enter([      
    listen("cava_data", #{      
        cmd: "scripts/cava-eww",    
        initial: "▁▁▁▁▁▁▁▁▁▁",      
    }),
    poll("wifi_data", #{
        cmd: "scripts/wifi_detect",
        interval: "400ms",
        initial: "󰤨 󰈀 Loading...",
    }),     
          
    defwindow("zewwiir", #{      
        monitor: 0,      
        windowtype: "desktop",      
        stacking: "bg",    
        wm_ignore: false,      
        geometry: #{      
            x: "0%",      
            y: "2px",      
            width: "90%",      
            height: "35px",      
            anchor: "top center"      
        },      
        exclusive: true,      
        resizable: true,      
        reserve: #{ distance: "40px", side: "top" }  , 
        class: "zewwiir"
    }, bar(cava_data, wifi_data))  
])
                                                                                                      