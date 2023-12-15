nobj = move_object();
nobj = nobj - 1;

while nobj > 0
    move_object();
    nobj = nobj - 1;
end

% do ready
system('PumaMoveXYZOAT 245.083 -177.876 -66.469 0.720 -0.014 -106.168 > /dev/null');
