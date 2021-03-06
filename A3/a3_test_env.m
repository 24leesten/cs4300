function smurf = a3_test_env()

testing = [0 1 0 0 0];
G = [0 1 1 1; 1 0 1 1; 1 1 0 1; 1 1 1 0];
D1 = [1 1 1 1; 1 1 1 1; 1 1 1 1; 1 1 1 1];
D2 = [1 0 0 0; 1 1 1 1; 1 1 1 1; 1 1 1 1];
D3 = [0 1 0 0; 1 1 1 1; 1 1 1 1; 1 1 1 1];
D4 = [1 1 1 1; 1 1 1 1; 0 0 0 1; 1 1 1 1];
D5 =   [0 0 1 0 1 1 1 0;
        0 0 0 0 0 0 1 0;
        1 1 1 1 1 1 0 1;
        1 1 0 0 1 0 1 1;
        1 0 0 1 0 1 1 1;
        0 1 0 1 0 0 1 1;
        0 1 0 1 0 1 0 1;
        1 1 0 0 1 0 1 0];

func = 'CS4300_AC3';

disp '===========================================';
disp (func);
disp 'MATRIX';
disp (G);
disp '===========================================';

if testing(1)
    disp 'QUEENS 1';
    disp (D1);
    result = feval(func, G,D1,'CS4300_n_queens_predicate');

    disp 'RESULT 1';
    disp (result);
    
    Check_1 = feval('CS4300_AC1', G, D1, 'CS4300_n_queens_predicate');
    
    if all(all(result == Check_1))
        disp 'Success';
    else
        disp 'FAILED';
    end
    
disp '===========================================';
end

if testing(2)
    disp 'QUEENS 2';
    disp (D2);
    result = feval(func, G,D2,'CS4300_n_queens_predicate');

    disp 'RESULT 2';
    disp (result);
    
    Check_2 = feval('CS4300_AC1', G, D2, 'CS4300_n_queens_predicate');
    
    if all(all(result == Check_2))
        disp 'Success';
    else
        disp 'FAILED';
    end
disp '===========================================';
end

if testing(3)
    disp 'QUEENS 3';
    disp (D3);
    result = feval(func, G,D3,'CS4300_n_queens_predicate');

    disp 'RESULT 3';
    disp (result);
    
    Check_3 = feval('CS4300_AC1', G, D3, 'CS4300_n_queens_predicate');
    
    if all(all(result == Check_3))
        disp 'Success';
    else
        disp 'FAILED';
    end
disp '===========================================';
end

if testing(4)
    disp 'QUEENS 4';
    disp (D4);
    result = feval(func, G,D4,'CS4300_n_queens_predicate');

    disp 'RESULT 4';
    disp (result);
    
    Check_4 = feval('CS4300_AC1', G, D4, 'CS4300_n_queens_predicate');
    
    if all(all(result == Check_4))
        disp 'Success';
    else
        disp 'FAILED';
    end
disp '===========================================';
end

if testing(5)
    G = ~eye(8, 8);
    disp 'QUEENS 5';
    disp (D5);
    result = feval(func, G,D5,'CS4300_n_queens_predicate');

    disp 'RESULT 5';
    disp (result);
    
    Check_5 = feval('CS4300_AC1', G, D5, 'CS4300_n_queens_predicate');
    
    if all(all(result == Check_5))
        disp 'Success';
    else
        disp 'FAILED';
    end
disp '===========================================';
end

smurf = [];