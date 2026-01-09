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
    poll("display_server", #{  
    interval: "3000ms",  
    cmd: "if [ '$XDG_SESSION_TYPE' = 'wayland' ] || [ -n '$WAYLAND_DISPLAY' ] && [ '$XDG_SESSION_TYPE' != 'x11' ]; then echo 'wayland'; else echo 'x11'; fi",  
    initial: "wayland",
    }),       
          
    defwindow("zewwiir", #{      
        monitor: 0,            
        stacking: "fg",        
        geometry: #{      
            x: "0%",      
            y: "2px",      
            width: "90%",      
            height: "35px",      
            anchor: "top center"      
        },      
        
        // Wayland options (evaluated conditionally)  
        exclusive: if display_server == "wayland" { true } else { false },  
        focusable: if display_server == "wayland" { "ondemand" } else { "none" },  
        namespace: if display_server == "wayland" { "my_layer_shell" } else { "" },  
      
        // X11 options (evaluated conditionally)  
        windowtype: if display_server == "x11" { "desktop" } else { "normal" },  
        reserve: if display_server == "x11" { #{ side: "top", distance: "34px" } } else { #{ side: "top", distance: "0px" } },  
        wm_ignore: if display_server == "x11" { true } else { false }, 
    }, bar(cava_data, wifi_data))  
])
                                                                                                      