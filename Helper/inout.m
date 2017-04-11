function [v,Boundaries,Elements,Forces] = inout(file)
%INOUT which reads a input file and collects the Elements,
%Boundaries,co-ordinates information
% Date: 19
% v is node coor
% exaple: v = [x1,y1,z1 ; x2,y2,z3 ; ....]

%file='patch_input.txt'
%fid = fopen(file,'r'); 

fid=fopen(file,'r');

while ~feof(fid);
   tline = fgetl(fid);  
    if strfind(tline, 'feap ') > 0;
        ui = ftell(fid);
        fseek(fid,ui,'bof');
        info =fscanf(fid,'%d\n',[1 6]);
        number_of_nodes=[info(1,1)];
        number_of_elements=[info(1,2)];
        material_parameters=[info(1,3)];
        degree_of_freedom=[info(1,4)];
        mesh_dimension=[info(1,5)];
        no_of_nodesproele=[info(1,6)];
    end
    if strfind(tline, 'Coor') > 0;
        ui = ftell(fid);
        fseek(fid,ui,'bof');
        %coo=fscanf(fid,'%f\n',[2+degree_of_freedom,number_of_nodes])'
        %coo_x =[coo(:,3) coo(:,4) ]
        [A] = (fscanf(fid, ['%f\n']))';
        [coo_x] = reshape(A,[],number_of_nodes)';
        
    end
    

   if strfind(tline, 'Elem') > 0;
        ui = ftell(fid);
        fseek(fid,ui,'bof');
        ele = (fscanf(fid, ['%f\n']))';
        Elements = reshape(ele,[],number_of_elements)';
   end 
   
   if strfind(tline, 'Boun') > 0;
        ui = ftell(fid);
        fseek(fid,ui,'bof');
        Boun = (fscanf(fid, ['%f\n']))';
        Boundaries = reshape(Boun,2+degree_of_freedom,[])';
   end 
 
    if strfind(tline, 'Forc') > 0;
        ui = ftell(fid);
        fseek(fid,ui,'bof');
        Forc=(fscanf(fid, ['%f\n']))';
        Forces=reshape(Forc,3+degree_of_freedom,[])';
    end
   
%    if strfind(tline, 'Material 1') > 0;
%        ui = ftell(fid);
%         fseek(fid,ui,'bof');
%        for i= 1:material_parameters*4;
% 
%  mat{i}= tline
%  tline = fgets(fid);
% 
%  end
%    end
   

    
  
end
% i=[1:9]
%  [m]=find(coo_x(:,1)==i)
%          if m>0
%      %for  i=coo_x(1,1):coo_x(:,end)               
%  x=[coo_x(m,:)]
%        %  end
%  end

 [Y,I] = sort(coo_x(:,1),1,'ascend') ;
   v = [Y coo_x(I,[2:2+mesh_dimension])];
   
      
      

      

end

