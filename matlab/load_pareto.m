performance_all=zeros(101,4,10);
feedback_types = ["18", "36", "180", "none"];
program_types=["orientfb", "angled", "angled_pn", "torque"];
p=4;
for f = 2:2:4    
    for r = 0:9
        directory_name = strcat(program_types(p),'/',program_types(p),'_',feedback_types(f),'/',program_types(p),'_',feedback_types(f),'_',string(r),'/');
        fullname = fullfile(directory_name, 'pareto.dat');
        pareto = load(fullname);
        remainder = pareto(:,1);
        remainder = rem(remainder,100);
        filtered_indices = find(~remainder);
        pareto = pareto(filtered_indices,:);
        id = pareto(:,2);
        filtered_indices = find(~id);        
        performance_all(1:size(filtered_indices,1),f,r+1) = pareto(filtered_indices,3);
        f
        r
   end
end
save("performance_100s_max_torque.mat", "performance_all");
