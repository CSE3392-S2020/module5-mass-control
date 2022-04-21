# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


//= require underscore
//= require canvas-toBlob
//= require file_saver.min
//= require dat.gui.min
//= require paper-core
//= require clipper
//= require paper2
//= require ruler

###############################  
###############################  
###############################  
###############################  
###############################  

class window.PaperJSApp
  ###
  Constructor
  ----
  Runs when a new instance of ColoringBook is invoked. If the global dat.gui 
  instance is found in the global scope, it will add button triggers to the 
  dat.gui controller. Lastly, it invokes the setup routine.
  ###
  
  constructor: (ops)->
    this.name = ops.name or "paperjs app"
    @setup(ops)
    console.log "✓ Paperjs Functionality"
    
  
  ###
  setup
  ----
  Configures the supplied canvasDOM element to fill the height and width of 
  its parent. It then installs the paper library in its scope. 
  ###
  
  setup: (ops)->
    canvas = ops.canvas[0]
    parent = $(ops.canvas[0]).parent()
   
    $(canvas)
      .attr('width', parent.width())
      .attr('height', parent.height())
    window.paper = new paper.PaperScope
    loadCustomLibraries()
    paper.setup canvas
    paper.view.zoom = 1
    $(canvas)
      .attr('width', parent.width())
      .attr('height', parent.height())
      
    
  ###
  save_svg
  ---
  Captures the current zoom level, changes to zoom level 1, produces an svg
  string of the scene graph, emits a file save actions, then restores the canvas
  to its original zoom level. 
  ###
  save_svg: ()->
    prev = paper.view.zoom;
    console.log("Exporting file as SVG");
    paper.view.zoom = 1;
    paper.view.update();
    exp = paper.project.exportSVG
      asString: true,
      precision: 5
    saveAs(new Blob([exp], {type:"application/svg+xml"}), @name + ".svg")
    paper.view.zoom = prev
    
  ###
  clear
  ----
  Removes all content from the canvas
  ###
  clear: ->
    paper.project.clear()
  ###
  ungroup
  ---
  A helper function for dissolving hierarchical structure of SVG.
  ###
  ungroup: (g)->
    _.each g.children, (child)->
      paper.project.activeLayer.appendTop(child)
  # Defined in inheritance
  toolEvents: ()-> return
  
  
  
###############################  
###############################  
###############################  
###############################  
###############################  
###############################  
###############################  
  
  