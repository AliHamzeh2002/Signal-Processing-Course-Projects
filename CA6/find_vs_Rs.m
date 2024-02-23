function [vs, Rs] = find_vs_Rs(fds, tds, beta)
    C = 3e8;
    P = 2 / C;
    vs = zeros(1, 2);
    Rs = zeros(1, 2);
    for i = 1:2
        vs(i) = fds(i) / beta;
        Rs(i) = tds(i) / P;
    end
end