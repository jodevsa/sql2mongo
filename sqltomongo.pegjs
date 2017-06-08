sql="select" _ cols:col _ "from" _ table:table _ where:where _  semicolon {
	let columns={}
  for(var i=0;i<cols.length;i++){
  	columns[cols[i]]=1;
  }

  return {"collection":table,"condition":where|| {},"columns":columns ||{}}



}
semicolon=";"?
objects=col
curly_where="("_ w:w _")"{
return w;
}


where=("where" _ w:w{
return w;

})?

  test=condition:(condition/curly_where) _ operator:((op:(and_operator/or_operator) _{return op}) )? {

    return {"condition":condition,"operator":operator}
  }
  w=data:(test)*  {

  	let original_object={}
  	let current_state=original_object;
    let previous_state=undefined;

    for(var i=0;i<data.length;i++){
        var current_operator=data[i]["operator"]

        if(!Array.isArray(current_state)){

        	if(( current_operator=== null && i==0)){
            	original_object=data[i]["condition"];
                continue;
            }

        	current_state["$"+current_operator]=[]
					previous_state=current_state;
            current_state=current_state["$"+current_operator]

            current_state.push(data[i]["condition"])
        }
        else{
        if(current_operator=== null && i==data.length-1 ){
        current_state.push(data[i]["condition"])
        	continue;
        }


		var length=current_state.length
       current_state.push({["$"+current_operator]:[data[i]["condition"]]})
	   previous_state=current_state

       current_state=current_state[current_state.length-1]["$"+current_operator]


        }

    }
            return original_object


  }
condition=condition_in/
		  condition_between/
		  condition_lower_or_equal/
		  condition_larger_or_equal/
		  condition_equal /
		  condition_larger /
          condition_lower /
          condition_lower_or_equal
condition_in=left:left _ ("in"/"IN") _ array:curly_array{
 let dic={};
 dic[left]={"$in":array}
 return dic;
}
curly_array="(" _ n:num_seq _")"{
let string_array="["+text().substring(1,text().length-1)+"]"
return JSON.parse(string_array);

}
num_seq=n1:right _ n2:("," _ right)*{}
condition_between= left:left _ ("between"/"BETWEEN") _ n1:number _ and_operator _ n2:number{

return {"$and":[{[left]:{"$gte":n1}},{[left]:{"$lte":n2}},]};
}
condition_lower_or_equal=left:left _ "<=" _ right:right{
let dic={};dic[left]={"$lte":right}
return dic;
}
condition_larger_or_equal=left:left _ ">=" _ right:right{
let dic={};dic[left]={"$gte":right}
return dic;
}
condition_larger=left:left _ ">" _ right:right{
let dic={};dic[left]={"$gt":right}
return dic;
}
condition_lower=left:left _ "<" _ right:right{
let dic={};dic[left]={"$lt":right}
return dic;
}
condition_equal=left:left _ "=" _ right:right{
let dic={};dic[left ]=right;
return dic;

}
and_operator="and"/"AND"
or_operator="or"/"OR"/"oR"/"Or"
left=text {return text()}
right=("true" /"True"/"TRUE"/"False"/"false"/"FALSE"){
return JSON.parse(text())
}/
('"'str:text'"'{return str.join("")})/("'"str:text'"'{return str.join()})
 /
number

compare="=" / "<" /">"
text=[a-zA-z0-9.!/ ]*
number= [0-9.]* {return JSON.parse(text())}
rtext=([a-zA-z0-9]/'"')*
table=tbl:[a-zA-z0-9]* {return text()}
col=col:[a-zA-z0-9/*,.]* {
var columns=text();

if(columns.search(',')===-1){
if(text()=="*")
return [];
else
return [text()]
}
var arr=[];
var split=text().split(',');

for(var i=0;i<split.length;i++){
    arr.push(split[i]);

}
return arr;
}
_ "whitespace"
  = [ \t\n\r]* {return  "whitespace"}
