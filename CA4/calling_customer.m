function calling_customer(customer_num, baje_num)
    if (customer_num >= 100 || customer_num <= 0 || baje_num >= 10 || baje_num <= 0)
        error('customer number must be between 1 and 99, baje number must be between 1 and 9');
    end
    load('map_set_data.mat');
    FS = 48000;
    sound(map_set('shomare'), FS);
    pause(2);
    
    if (customer_num > 20 && mod(customer_num, 10) ~= 0)
        sound(map_set(num2str(floor(customer_num / 10) * 10)), FS);
        pause(0.5);
        sound(map_set('o'), FS);
        pause(0.6);
        sound(map_set(num2str(mod(customer_num, 10))), FS);
    else
        sound(map_set(num2str(customer_num)), FS);
    end
       pause(1); 
    sound(map_set('baje'), FS);
    pause(2);
    sound(map_set(num2str(baje_num)), FS);
end
