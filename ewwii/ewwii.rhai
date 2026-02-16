//////////////////////////////////////////////////////  
// Author: Zyxtyz                                   //  
// Github Repo: https://github.com/zyxtyz/ZyXtArch  //  
// Last Update: 18.12.2025 10:35:30                 //  
//////////////////////////////////////////////////////  
import "api::linux" as linux;  
import "std::command" as cmd;  
import "std::env" as env;  
  
let display_server = env::get_env("XDG_SESSION_TYPE");  
  
fn safe_get(arr, i) {  
    if i < arr.len() { arr[i] } else { "" }  
}  
  
fn menu(music_met) {  
    return box(#{  
        orientation: "horizontal",  
        space_evenly: false,  
        class: "menu",  
    }, [  
       music(music_met),  
    ]);  
}  
  
fn music(music_met) {  
    return box(#{  
        orientation: "horizontal",  
        space_evenly: true,  
        class: "music",  
    }, [  
        image(#{path: music_met.art })  
    ]);  
}  
  
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
    ]);  
}  
  
fn wifi_widget(wifi) {  
    return box(#{  
        orientation: "horizontal",  
    }, [  
        label(#{ text: wifi, class: "wifi"})  
    ]);  
}  
  
// Create music metadata object from poll data  
let music_met = #{  
    title:  "",  
    artist: "",  
    album:  "",  
    status: "",  
    art:    ""  
};  
  
// Update function to parse music metadata  
fn update_music_meta(music_meta) {  
    let parts = m.split("|");  
    return #{  
        title:  safe_get(parts, 0),  
        artist: safe_get(parts, 1),  
        album:  safe_get(parts, 2),  
        status: safe_get(parts, 3),  
        art:    safe_get(parts, 4)  
    };  
}  
  
enter([        
    poll("music_meta", #{  
        interval: "100ms",  
        cmd: "scripts/music-eww",  
        initial: "",  
    }),  
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
        namespace: if display_server == "wayland" { "bar" } else { "" },    
        
        // X11 options (evaluated conditionally)    
        windowtype: if display_server == "x11" { "desktop" } else { "normal" },    
        reserve: if display_server == "x11" { #{ side: "top", distance: "34px" } } else { #{ side: "top", distance: "0px" } },    
        wm_ignore: if display_server == "x11" { true } else { false },   
    }, bar(cava_data, wifi_data)),  
      
      
    defwindow("menu", #{        
        monitor: 0,              
        stacking: "fg",          
        geometry: #{        
            x: "0%",        
            y: "20px",        
            width: "40%",        
            height: "40%",        
            anchor: "top center"        
        },      
          
        // Wayland options (evaluated conditionally)    
        focusable: if display_server == "wayland" { "ondemand" } else { "none" },    
        namespace: if display_server == "wayland" { "menu" } else { "" },    
        
        // X11 options (evaluated conditionally)    
        windowtype: if display_server == "x11" { "desktop" } else { "normal" },     
        wm_ignore: if display_server == "x11" { true } else { false },   
    }, menu(update_music_meta(music_meta)))  
])