function [v, R] = find_v_R(fd, td, beta)
    C = 3e8;
    P = 2 / C;
    v = fd / beta;
    R = td * C / 2;
end
