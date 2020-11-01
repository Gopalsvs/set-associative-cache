module project();
//main memory
reg [0:4294967295] memory[6:0];

//cache components
reg valid[0:255][15:0]; 
reg [7:0]   index[0:255] ;
reg [19:0]  tag[0:255][0:15];
reg[6:0] data[0:255][0:15];
reg [3:0]   lru[0:255];

//inputs storin
reg [31:0] address;
reg[4:0] inst; 
integer data_file,tmp,data1,i,j;

initial begin
for(i=0;i<256;i=i+1)begin
	for(j=0;j<16;j=j+1)begin
		valid[i][j]=0;
	end
end
data_file=$fopen("test.trace","r");
while(!$feof(data_file)) begin
	tmp=$fscanf(data_file,"%s%h%h\n",inst,address,data1);
	if(inst==5'h0c)
	begin
		if(valid[address[11:4]][address[3:0]]==0)
		begin
			valid[address[11:4]][address[3:0]]=1;
			index[address[11:4]]=address[11:4];
			tag[address[11:4]][address[3:0]]=address[31:12];
			data[address[11:4]][address[3:0]]=data1;
		end
	end
	$display("%d",valid[address[11:4]][address[3:0]]);
	$display("%h",index[address[11:4]]);
	$display("%h",tag[address[11:4]][address[3:0]]);
	$display("%h",data[address[11:4]][address[3:0]]);
end 
$fclose(data_file);
end
endmodule
