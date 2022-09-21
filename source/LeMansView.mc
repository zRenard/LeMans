import Toybox.WatchUi;
import Toybox.Graphics;
import Toybox.System;
import Toybox.Time;
import Toybox.Time.Gregorian;
import Toybox.Lang;
import Toybox.Application;

class LeMansView extends WatchUi.WatchFace {
	var sleepMode = false;

    public function initialize() {
        WatchFace.initialize();
        sleepMode = false;        
    }

    function onLayout(dc) {
        setLayout(Rez.Layouts.WatchFace(dc));
    }

    function onShow() {
    }

    function onUpdate(dc) {
    	var myApp = Application.getApp();
    	var width = dc.getWidth();
	    var height = dc.getHeight();

    	var LeMansBlue = readKeyInt(myApp,"LeMansBlueColor",0x00AAFF);
	   	var LeMansOrange = readKeyInt(myApp,"LeMansOrangeColor",0xFFAA00);
    	var bgC = readKeyInt(myApp,"BackgroundColor",0xFFFFFF);
    	var fgC = readKeyInt(myApp,"ForegroundColor",0x000000);
    	var showNotification = readKeyBoolean(myApp,"ShowNotification",true);
    	var showBattery = readKeyBoolean(myApp,"ShowBattery",true);
    	var showBatteryCritical = readKeyBoolean(myApp,"ShowBatteryCritical",true);
		var batteryLevelCritical = readKeyInt(myApp,"BatteryLevelCritical",30);    	
    	var clockTime = System.getClockTime();
    	
        if (dc has :setAntiAlias ) { dc.setAntiAlias(true); }
    	dc.setColor(bgC,bgC);
    	dc.clear();
    	    	
       	dc.setColor(LeMansBlue,Graphics.COLOR_TRANSPARENT);
        dc.fillCircle(width / 2, height / 2, (width / 2)-20);
    
        dc.setColor(LeMansOrange, Graphics.COLOR_TRANSPARENT);
	    dc.fillRectangle((width / 2)-20, 0, 40, height);
    	dc.setColor(fgC,Graphics.COLOR_TRANSPARENT);    	
    	dc.setPenWidth(2);
	    dc.drawLine((width / 2)-20, 0,(width / 2)-20, height);
	    dc.drawLine((width / 2)+20, 0,(width / 2)+20, height);

    	dc.setPenWidth(20);
    	dc.setColor(bgC,Graphics.COLOR_TRANSPARENT);    	
        dc.drawCircle(width / 2, height / 2, (width / 2)-10);
    
    	dc.setColor(bgC,Graphics.COLOR_TRANSPARENT);
    	// 12 circle
        dc.fillCircle(width / 2, 70, 30);
    	dc.setColor(fgC,Graphics.COLOR_TRANSPARENT);    	
        dc.drawText(width / 2, 70-Graphics.getFontHeight(Graphics.FONT_NUMBER_MILD )/2, Graphics.FONT_NUMBER_MILD ,"12", Graphics.TEXT_JUSTIFY_CENTER);
    	dc.setColor(bgC,Graphics.COLOR_TRANSPARENT);    	
		//1
		dc.drawText((width / 2)+40, -70+height/2-Graphics.getFontHeight(Graphics.FONT_XTINY )/2, Graphics.FONT_XTINY ,"1", Graphics.TEXT_JUSTIFY_CENTER);
		//11
		dc.drawText((width / 2)-40, -70+height/2-Graphics.getFontHeight(Graphics.FONT_XTINY )/2, Graphics.FONT_XTINY ,"11", Graphics.TEXT_JUSTIFY_CENTER);
		//2
		dc.drawText((width / 2)+67, -45+height/2-Graphics.getFontHeight(Graphics.FONT_XTINY )/2, Graphics.FONT_XTINY ,"2", Graphics.TEXT_JUSTIFY_CENTER);
		//10
		dc.drawText((width / 2)-67, -45+height/2-Graphics.getFontHeight(Graphics.FONT_XTINY )/2, Graphics.FONT_XTINY ,"10", Graphics.TEXT_JUSTIFY_CENTER);
		//3
		dc.drawText((width / 2)+75, height/2-Graphics.getFontHeight(Graphics.FONT_MEDIUM )/2, Graphics.FONT_MEDIUM ,"3", Graphics.TEXT_JUSTIFY_CENTER);
		//4
		dc.drawText((width / 2)+67, +40+height/2-Graphics.getFontHeight(Graphics.FONT_XTINY )/2, Graphics.FONT_XTINY ,"4", Graphics.TEXT_JUSTIFY_CENTER);
		//8
		dc.drawText((width / 2)-67, +40+height/2-Graphics.getFontHeight(Graphics.FONT_XTINY )/2, Graphics.FONT_XTINY ,"8", Graphics.TEXT_JUSTIFY_CENTER);
		//5
		dc.drawText((width / 2)+40, +65+height/2-Graphics.getFontHeight(Graphics.FONT_XTINY )/2, Graphics.FONT_XTINY ,"5", Graphics.TEXT_JUSTIFY_CENTER);
		//7
		dc.drawText((width / 2)-40, +65+height/2-Graphics.getFontHeight(Graphics.FONT_XTINY )/2, Graphics.FONT_XTINY ,"7", Graphics.TEXT_JUSTIFY_CENTER);
        //6
        dc.drawText(width / 2, (height/2)+50, Graphics.FONT_MEDIUM ,"6", Graphics.TEXT_JUSTIFY_CENTER);
		//9
		dc.drawText((width / 2)-75, height/2-Graphics.getFontHeight(Graphics.FONT_MEDIUM )/2, Graphics.FONT_MEDIUM ,"9", Graphics.TEXT_JUSTIFY_CENTER);
		
		// Ticks
    	drawTicks(dc,fgC,3,(width / 2),19,30.0,0);
    	drawTicks(dc,fgC,2,(width / 2),10,15.0,0);
    	drawTicks(dc,fgC,1,(width / 2),5,3.0,0);

    	drawTicks(dc,bgC,3,(width / 2),15,90.0,20);
    	drawTicks(dc,bgC,2,(width / 2),10,30.0,20);
    	drawTicks(dc,bgC,1,(width / 2),5,6.0,20);

		// Clock Hands
		var minuteHandAngle;
        var hourHandAngle;
        var secondHandAngle;
		var centerX = width / 2;
		var centerY = height / 2;
		
		secondHandAngle = clockTime.sec * Math.PI / 30;
		var sx = centerX + Math.sin(secondHandAngle) * ((width / 4)+5);
		var sy = centerY - Math.cos(secondHandAngle) * ((width / 4)+5);
	 
		minuteHandAngle = (clockTime.min + clockTime.sec / 60.0) / 30 * Math.PI;
		var mx = centerX + Math.sin(minuteHandAngle) * (width / 2);
		var my = centerY - Math.cos(minuteHandAngle) * (width / 2);
	 
		hourHandAngle = (clockTime.hour + clockTime.min / 60.0) / 6 * Math.PI;
		var hx = centerX + Math.sin(hourHandAngle) * ((width / 2)-24);
		var hy = centerY - Math.cos(hourHandAngle) * ((width / 2)-24);
		
    	dc.setColor(fgC,Graphics.COLOR_TRANSPARENT);    	
		// Hands Circle at center
        dc.fillCircle(centerX, centerY, 10);
        // Hours
    	dc.setPenWidth(6);
		dc.drawLine(centerX,centerY,hx,hy);
		// Minutes		
    	dc.setPenWidth(4);
		dc.drawLine(centerX,centerY,mx,my);
		// Seconds		
		if (!sleepMode) {
    		dc.setPenWidth(2);
			dc.drawLine(centerX,centerY,sx,sy);
    	}

		// Notification circles
		dc.setPenWidth(1);
        // Center
        dc.setColor(LeMansOrange,Graphics.COLOR_TRANSPARENT);
	    dc.fillCircle((width / 2), (height/8)*5, 13);
	    dc.setColor(bgC,Graphics.COLOR_TRANSPARENT);
        dc.drawCircle((width / 2), (height/8)*5, 13);
        dc.drawCircle((width / 2), (height/8)*5, 15);
        dc.fillEllipse((width / 2),1+(height/8)*5, 15,8);
        
	    dc.setColor(fgC,Graphics.COLOR_TRANSPARENT);
	    dc.drawEllipse((width / 2),1+(height/8)*5, 15,8);
        dc.drawCircle((width / 2), (height/8)*5, 14);
        
       	var nowText = Gregorian.info(Time.now(), Time.FORMAT_MEDIUM);      
        var myDay = Lang.format("$1$",[nowText.day.format("%d")]);
   		dc.drawText((width / 2), (height/8)*5-Graphics.getFontHeight(Graphics.FONT_XTINY )/2, Graphics.FONT_XTINY ,myDay, Graphics.TEXT_JUSTIFY_CENTER);        
        // Left
		if (showBattery||showBatteryCritical) {
	    	var battery = System.getSystemStats().battery;
			var textBattery = (battery + 0.5).toNumber();
			if (battery<=batteryLevelCritical || showBattery) {
			    dc.setColor(fgC,Graphics.COLOR_TRANSPARENT);
		        dc.fillCircle((width / 2)-40, 130, 13);
		  	    dc.setColor(bgC,Graphics.COLOR_TRANSPARENT);
		        dc.drawCircle((width / 2)-40, 130, 13);
				dc.drawText((width / 2)-40, 129-Graphics.getFontHeight(Graphics.FONT_XTINY )/2, Graphics.FONT_XTINY ,textBattery, Graphics.TEXT_JUSTIFY_CENTER);        
			}
		}
		// Right
		if (showNotification) {
			var notification = System.getDeviceSettings().notificationCount;
			if (notification > 0) {
			    dc.setColor(bgC,Graphics.COLOR_TRANSPARENT);
		        dc.fillCircle((width / 2)+40, 130, 13);
		  	    dc.setColor(fgC,Graphics.COLOR_TRANSPARENT);
		        dc.drawCircle((width / 2)+40, 130, 13);
				dc.drawText((width / 2)+40, 129-Graphics.getFontHeight(Graphics.FONT_XTINY )/2, Graphics.FONT_XTINY ,notification, Graphics.TEXT_JUSTIFY_CENTER);
			}
		}
    }

    function drawTicks(dc,color,size,out,innerOffset,angle,offset) {
    	dc.setPenWidth(size);
    	dc.setColor(color,Graphics.COLOR_TRANSPARENT);    	

		var sX, sY;
        var eX, eY;
        var outerRad = out - offset;
        var innerRad = outerRad - innerOffset;
                
        for (var i = 0; i < Math.toRadians(360); i += Math.toRadians(angle)) {
            sY = offset + outerRad + innerRad * Math.sin(i);
            eY = offset + outerRad + outerRad * Math.sin(i);
            sX = offset + outerRad + innerRad * Math.cos(i);
            eX = offset + outerRad + outerRad * Math.cos(i);
            dc.drawLine(sX, sY, eX, eY);
        }
	}
	
    function onHide() {
    }

    function onExitSleep() {
		sleepMode = false;        
    }

    function onEnterSleep() {
		sleepMode = true;
    }
    
    function readKeyInt(myApp,key,thisDefault) {
	    var value = myApp.getProperty(key);
	    if(value == null || !(value instanceof Number)) {
	        if(value != null) {
	            value = value.toNumber();
	        } else {
	            value = thisDefault;
	        }
	    }
	    return value;
   }
   function readKeyBoolean(myApp,key,thisDefault) {
	    var value = myApp.getProperty(key);
	    if(value == null || !(value instanceof Boolean)) {
	        if(value != null) {
	            value = true;
	        } else {
	            value = thisDefault;
	        }
	    }
	    return value;
   }
}
