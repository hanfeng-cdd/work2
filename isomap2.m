function [ISO_x]=isomap2(V,D,d)
                     
 ISO_x=V(:,1:d)*(sqrt(D(1:d,1:d)));    

end


    
