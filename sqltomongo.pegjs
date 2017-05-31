{var _conditions=[];
var base_object={"$and":[]}
var second_object={};
var table="";
var _where={}
var last="dict";
var big=_where

}
sql="select" _ cols:col _ "from" _ table:table _ where:where _  semicolon {
  for(var i=0;i<cols.length;i++){
  	second_object[cols[i]]=1;
  }

  return {"collection":table,"conditions":_where,"show":second_object}



}
semicolon=";"?
objects=col
curly_where="("_ w:w _")"{


if(!Array.isArray(big)){

	_where=w;
    }
else{

big.push(w)
}
return w;

}


where=("where" _ w:w{


if(!Array.isArray(big)){

	_where=w;
    }
else{
big.push(w)
}
return w;})?

  w=c:condition _ lol:((and_operator/or_operator) _ M:(w))*  {


    let test=lol[0]



    if(test!=undefined && test.length==3 && test[0]=="and"){


    	console.log(test[0])
        if(!Array.isArray(big)){
    	big["$and"]=[test[2]];
        big=big["$and"]
        //alert(JSON.stringify(big));
		}
        else{

        let dic={}
        dic["$and"]=[test[2]];
        big.push(dic);
        big=dic["$and"];

        }


    }
    if(test!=undefined && test.length==3 && test[0]=="or"){


    	console.log(test[0])

           if(!Array.isArray(big)){
    	big["$or"]=[test[2]];
        big=big["$or"]
		}
        else{

        let dic={}
        dic["$or"]=[test[2]];
        big.push(dic);
        big=dic["$or"];
        }


    }



    return c;
  }
condition=condition_in/
		  condition_between/
		  condition_lower_or_equal/
		  condition_larger_or_equal/
		  condition_equal /
		  condition_larger /
          condition_lower /
          condition_lower_or_equal
condition_in=left _ ("in"/"IN") _ array:curly_array{
return {"$in":array}
}
curly_array="(" _ n:num_seq _")"{
let string_array="["+text().substring(1,text().length-1)+"]"
return JSON.parse(string_array);

}
num_seq=n1:right _ n2:("," _ right)*{}
condition_between= left _ ("between"/"BETWEEN") _ n1:number _ and_operator _ n2:number{
let dic={"$and":{}}
dic["$and"]=[];
dic["$and"].push({"$lte":n2})
dic["$and"].push({"gte":n1})
return dic;
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
'"'str:text'"'
{return str.join("")} /
number

compare="=" / "<" /">"
text=[a-zA-z0-9.!/]*
number= [0-9.]* {return JSON.parse(text())}
rtext=([a-zA-z0-9]/'"')*
table=tbl:[a-zA-z0-9]* {table=text();return text()}
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
  = [ \t\n\r]* {}
