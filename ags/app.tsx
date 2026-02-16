#!/usr/bin/env -S ags run

import app from "ags/gtk4/app"  
import Bar from "./widget/Bar"  
import { readFileAsync, monitorFile } from "ags/file"  
  
let style = await readFileAsync("./style.scss")  
app.start({ css: style, main: () => Bar() })  
  
monitorFile("./", async (file, event) => {  
  if (file.endsWith(".scss")) {  
    const updated = await readFileAsync("./style.scss")  
    app.reset_css()  
    app.apply_css(updated)  
  }  
})
