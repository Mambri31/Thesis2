%% Starting from the output of a system, it creates a cells of vector

function cells=cell_q_maker(out_sys,rangeK,rangeB,H_K)

nk=length(rangeK);
nb=length(rangeB);
cells=cell(nb,nk);

if H_K==1 %Hip
   for k=1:nk
       for b=1:nb
           qhi=out_sys((k-1)*nb+b).qhout;
           cells{b,k}=qhi(:);
       end
   end


elseif H_K==0 %Knee
   for k=1:nk
       for b=1:nb
           qhdoti=out_sys((k-1)*nb+b).qkout;     
           cells{b,k}=qhdoti(:);
       end
   end

else
    disp('Error H_K has to be 1(Hip) or 0(Knee)')

end
      
end