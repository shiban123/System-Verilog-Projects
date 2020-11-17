
module lcd_driver_4 ( alarm_time_ms_hr,
                      alarm_time_ls_hr,
                      alarm_time_ms_min,
                      alarm_time_ls_min,
                      current_time_ms_hr,
                      current_time_ls_hr,
                      current_time_ms_min,
                      current_time_ls_min,
                      key_ms_hr,
                      key_ls_hr,
                      key_ms_min,
                      key_ls_min,
                      show_a,
                      show_current_time,
                      display_ms_hr,
                      display_ls_hr,
                      display_ms_min,
                      display_ls_min,
                      sound_a);
// Define input and output port directions
input [3:0] alarm_time_ms_hr,
            alarm_time_ls_hr,
            alarm_time_ms_min,
            alarm_time_ls_min,
            current_time_ms_hr,
            current_time_ls_hr,
            current_time_ms_min,
            current_time_ls_min,
            key_ms_hr,
            key_ls_hr,
            key_ms_min,
            key_ls_min;
            
input show_a,
      show_current_time;

output [7:0] display_ms_hr,
             display_ls_hr,
             display_ms_min,
             display_ls_min;

output sound_a;

wire sound_alarm1,sound_alarm2,sound_alarm3,sound_alarm4;
// Assert sound_a when all 4 digits matches
assign sound_a = sound_alarm1 & sound_alarm2 & sound_alarm3 & sound_alarm4 ;

//Instantiate lcd_driver as MS_HR_display
lcd_driver MS_HR (.alarm_time(alarm_time_ms_hr), 
                  .current_time(current_time_ms_hr),
                  .key(key_ms_hr),
                  .show_alarm(show_a),
                  .show_new_time(show_current_time),
                  .display_time(display_ms_hr),
                  .sound_alarm(sound_alarm1));
//Instantiate lcd_driver as LS_HR_display
lcd_driver LS_HR (.alarm_time(alarm_time_ls_hr), 
                  .current_time(current_time_ls_hr),
                  .key(key_ls_hr),
                  .show_alarm(show_a),
                  .show_new_time(show_current_time),
                  .display_time(display_ls_hr),
                  .sound_alarm(sound_alarm2));

//Instantiate lcd_driver as MS_MIN_display
lcd_driver MS_MIN (.alarm_time(alarm_time_ms_min), 
                   .current_time(current_time_ms_min),
                   .key(key_ms_min),
            .show_alarm(show_a),
            .show_new_time(show_current_time),
            .display_time(display_ms_min),
            .sound_alarm(sound_alarm3));

//Instantiate lcd_driver as LS_MIN_display
lcd_driver LS_MIN(.alarm_time(alarm_time_ls_min), 
                  .current_time(current_time_ls_min),
                  .key(key_ls_min),
                  .show_alarm(show_a),
                  .show_new_time(show_current_time),
                  .display_time(display_ls_min),
                  .sound_alarm(sound_alarm4));


endmodule


               
