/**
 * Unicorn Admin Template
 * Diablo9983 -> diablo9983@gmail.com
**/
$(document).ready(function(){
	
    unicorn.init();
	
    $('#add-event-submit').click(function(){
        unicorn.add_event();
    });
	
    $('#event-name').keypress(function(e){
        if(e.which == 13) {	
            unicorn.add_event();
        }
    });

        
});

unicorn = {	
	
    // === Initialize the fullCalendar and external draggable events === //
    init: function() {	
        // Prepare the dates
        var date = new Date();
        var d = date.getDate();
        var m = date.getMonth();
        var y = date.getFullYear();	
		
        $('#fullcalendar').fullCalendar({
            
            
            dayClick: function(date, allDay, jsEvent, view) {
              
                $("#date").text(date.getDate()+"/"+(date.getMonth()+1)+"/"+date.getFullYear());   //SET DATE
              
                if(view.name == "month"){
                    //if day is clicked, zoom to actual day with day view
                    $("#fullcalendar").fullCalendar( 'changeView', "agendaDay" );
                    $("#fullcalendar").fullCalendar( 'gotoDate', date);
                    
                }
                
            },
            selectable: true,
            selectHelper: true,
            unselectAuto: false,
            select: function(start, end, allDay) {
                // if end date is longer than 2 hours, snap back to only two hours ** not working :(
//                if(end.getTime() - start.getTime() > 3600 * 1000 * 2){
//                    var adjustedEndTime = start.getTime() + 3600 * 1000 * 2;
//                    end = new Date(adjustedEndTime);
//                }
               
               $("#time").text(start.customFormat("#h#:#mm# #ampm#") + " - " + end.customFormat("#h#:#mm# #ampm#"));   //SET TIME
               
                title = "test";
                if (title) {
                    $("fullcalendar").fullCalendar('renderEvent',
                    {
                        title: title,
                        start: start,
                        end: end,
                        allDay: allDay
                    },
                    true // make the event "stick"
                    );
                     
                }
                $("fullcalendar").fullCalendar('unselect');
                $("fullcalendar").fullCalendar('render');
            },

                    
            header: {
                left: 'prev,next',
                center: 'title',
                right: 'month,agendaWeek,agendaDay'
            },
            titleFormat: {
                month: 'MMMM yyyy',                             // September 2009
                week: "MMM d[ yyyy]{ '&#8212;'[ MMM] d yyyy}", // Sep 7 - 13 2009
                day: ''                  // Tuesday, Sep 8, 2009
            },
            editable: true,
            droppable: true, // this allows things to be dropped onto the calendar !!!
            drop: function(date, allDay) { // this function is called when something is dropped
				
                // retrieve the dropped element's stored Event Object
                var originalEventObject = $(this).data('eventObject');
					
                // we need to copy it, so that multiple events don't have a reference to the same object
                var copiedEventObject = $.extend({}, originalEventObject);
					
                // assign it the date that was reported
                copiedEventObject.start = date;
                copiedEventObject.allDay = allDay;
					
                // render the event on the calendar
                // the last `true` argument determines if the event "sticks" (http://arshaw.com/fullcalendar/docs/event_rendering/renderEvent/)
                $('#fullcalendar').fullCalendar('renderEvent', copiedEventObject, true);
					
                // is the "remove after drop" checkbox checked?
				
                // if so, remove the element from the "Draggable Events" list
                $(this).remove();
				
            }
        });
        this.external_events();		
    },
	
    // === Adds an event if name is provided === //
    add_event: function(){
        if($('#event-name').val() != '') {
            var event_name = $('#event-name').val();
            $('#external-events .panel-content').append('<div class="external-event ui-draggable label label-inverse">'+event_name+'</div>');
            this.external_events();
            $('#modal-add-event').modal('hide');
            $('#event-name').val('');
        } else {
            this.show_error();
        }
    },
	
    // === Initialize the draggable external events === //
    external_events: function(){
        /* initialize the external events
		-----------------------------------------------------------------*/
        $('#external-events div.external-event').each(function() {		
            // create an Event Object (http://arshaw.com/fullcalendar/docs/event_data/Event_Object/)
            // it doesn't need to have a start or end
            var eventObject = {
                title: $.trim($(this).text()) // use the element's text as the event title
            };
				
            // store the Event Object in the DOM element so we can get to it later
            $(this).data('eventObject', eventObject);
				
            // make the event draggable using jQuery UI
            $(this).draggable({
                zIndex: 999,
                revert: true,      // will cause the event to go back to its
                revertDuration: 0  //  original position after the drag
            });		
        });		
    },
	
    // === Show error if no event name is provided === //
    show_error: function(){
        $('#modal-error').remove();
        $('<div style="border-radius: 5px; top: 70px; font-size:14px; left: 50%; margin-left: -70px; position: absolute;width: 140px; background-color: #f00; text-align: center; padding: 5px; color: #ffffff;" id="modal-error">Enter event name!</div>').appendTo('#modal-add-event .modal-body');
        $('#modal-error').delay('1500').fadeOut(700,function() {
            $(this).remove();
        });
    }
	
	
};


// UTILITY METHOD

Date.prototype.customFormat = function(formatString){
    var YYYY,YY,MMMM,MMM,MM,M,DDDD,DDD,DD,D,hhh,hh,h,mm,m,ss,s,ampm,AMPM,dMod,th;
    var dateObject = this;
    YY = ((YYYY=dateObject.getFullYear())+"").slice(-2);
    MM = (M=dateObject.getMonth()+1)<10?('0'+M):M;
    MMM = (MMMM=["January","February","March","April","May","June","July","August","September","October","November","December"][M-1]).substring(0,3);
    DD = (D=dateObject.getDate())<10?('0'+D):D;
    DDD = (DDDD=["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"][dateObject.getDay()]).substring(0,3);
    th=(D>=10&&D<=20)?'th':((dMod=D%10)==1)?'st':(dMod==2)?'nd':(dMod==3)?'rd':'th';
    formatString = formatString.replace("#YYYY#",YYYY).replace("#YY#",YY).replace("#MMMM#",MMMM).replace("#MMM#",MMM).replace("#MM#",MM).replace("#M#",M).replace("#DDDD#",DDDD).replace("#DDD#",DDD).replace("#DD#",DD).replace("#D#",D).replace("#th#",th);

    h=(hhh=dateObject.getHours());
    if (h==0) h=24;
    if (h>12) h-=12;
    hh = h<10?('0'+h):h;
    AMPM=(ampm=hhh<12?'am':'pm').toUpperCase();
    mm=(m=dateObject.getMinutes())<10?('0'+m):m;
    ss=(s=dateObject.getSeconds())<10?('0'+s):s;
    return formatString.replace("#hhh#",hhh).replace("#hh#",hh).replace("#h#",h).replace("#mm#",mm).replace("#m#",m).replace("#ss#",ss).replace("#s#",s).replace("#ampm#",ampm).replace("#AMPM#",AMPM);
}