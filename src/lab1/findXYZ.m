function M = findXYZ(uv_left, uv_right, P_left, P_right)
    
    
    b = [uv_right(1) * P_right(3,4) - P_right(1,4);
         uv_right(2) * P_right(3,4) - P_right(2,4);
         uv_left(1) * P_left(3,4) - P_left(1,4);
         uv_left(2) * P_left(3,4) - P_right(2,4)];

    A = [P_right(1,1:3) - uv_right(1) * P_right(3,1:3);
         P_right(2,1:3) - uv_right(2) * P_right(3,1:3);
         P_left(1,1:3) - uv_left(1) * P_left(3,1:3);
         P_left(2,1:3) - uv_left(2) * P_left(3,1:3)];

     M = pinv(A) * b;
end