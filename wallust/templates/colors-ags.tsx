export const colors = {  
  // Wallust template placeholders  
  background: "{{background}}",  
  foreground: "{{foreground}}",  
  wallpaper: "{{wallpaper}}",  
  cursor: "{{cursor}}",  
    
  // Color palette (color0 to color15)  
  color0: "{{color0}}",   // black  
  color1: "{{color1}}",   // red  
  color2: "{{color2}}",   // green  
  color3: "{{color3}}",   // yellow  
  color4: "{{color4}}",   // blue  
  color5: "{{color5}}",   // magenta  
  color6: "{{color6}}",   // cyan  
  color7: "{{color7}}",   // white  
  color8: "{{color8}}",   // bright black  
  color9: "{{color9}}",   // bright red  
  color10: "{{color10}}", // bright green  
  color11: "{{color11}}", // bright yellow  
  color12: "{{color12}}", // bright blue  
  color13: "{{color13}}", // bright magenta  
  color14: "{{color14}}", // bright cyan  
  color15: "{{color15}}", // bright white  
}  
  
// CSS variables template for wallust processing  
export const cssVariables = `  
  @define-color background {{background}};  
  @define-color foreground {{foreground}};  
  @define-color wallpaper {{wallpaper}};  
  @define-color cursor {{cursor}};  
    
  @define-color color0 {{color0}};  
  @define-color color1 {{color1}};  
  @define-color color2 {{color2}};  
  @define-color color3 {{color3}};  
  @define-color color4 {{color4}};  
  @define-color color5 {{color5}};  
  @define-color color6 {{color6}};  
  @define-color color7 {{color7}};  
  @define-color color8 {{color8}};  
  @define-color color9 {{color9}};  
  @define-color color10 {{color10}};  
  @define-color color11 {{color11}};  
  @define-color color12 {{color12}};  
  @define-color color13 {{color13}};  
  @define-color color14 {{color14}};  
  @define-color color15 {{color15}};  
`  
