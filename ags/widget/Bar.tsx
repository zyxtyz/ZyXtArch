import app from "ags/gtk4/app"  
import { Astal, Gtk, Gdk } from "ags/gtk4"  
import { createPoll } from "ags/time"
import Hyprland from "gi://AstalHyprland"
import Mpris from "gi://AstalMpris"
import Tray from "gi://AstalTray"
import Network from "gi://AstalNetwork"
import Notifd from "gi://AstalNotifd"
import Cava from "gi://AstalCava"



export default function Bar() {  
  const hyprland = Hyprland.get_default()
  const current_client_title = hyprland.focused_client.title
  const time = createPoll("", 1000, "date")  
  const { TOP, LEFT, RIGHT, BOTTOM } = Astal.WindowAnchor  
  
  return (  
    <window  
      visible  
      monitor={0}  
      exclusivity={Astal.Exclusivity.EXCLUSIVE}  
      anchor={ TOP }  
      namespace="bar"
      cssName="bar"
      name="bar"
      widthRequest={1900}
      heightRequest={35}
      css="margin-top: 5px;"
    >  
      <centerbox orientation={Gtk.Orientation.HORIZONTAL}>
    <box 
        $type="start"

        
    />
    <label label="hello" $type="center" />
    <label label="no :3" $type="end" />
        

      </centerbox>  
    </window>  
  )  
}
