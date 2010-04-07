

$(function(){
slider.init();
});

var slider={
 num:-1,
 cur:0,
 cr:[],
 al:null,
 at:5*1000,
 ar:true,
 init:function(){

  slider.slides = $(".slide");
  var d=slider.data;
  slider.num=slider.slides.length;
  var pos=Math.floor(Math.random()*1);//slider.num);
  for(var i=0;i<slider.num;i++){
   slider.slides.eq(i).css({left:((i-pos)*940)});
   slider.slides.eq(i).css({left:0});
   //$('#slide-nav').append('<a id="slide-link-'+i+'" href="#" onclick="slider.slide('+i+');return false;" onfocus="this.blur();">'+(i+1)+'</a>');
  }

  $('img,div#slide-controls',$('div#slide-holder')).fadeIn();
  //slider.text(slider.slides.eq(pos).attr("alt"));
  slider.on(pos);
  slider.cur=pos;
  window.setTimeout('slider.auto();',slider.at);
 },
 auto:function(){
  if(!slider.ar)
   return false;

  var next=slider.cur+1;
  if(next>=slider.num) next=0;
  slider.slide(next);
 },
 slide:function(pos){
  if(pos<0 || pos>=slider.num || pos==slider.cur)
   return;

  window.clearTimeout(slider.al);
  slider.al=window.setTimeout('slider.auto();',slider.at);

 

   //slider.slides.eq(i).stop().animate({left:((i-pos)*940)},1000,'swing');
   
   slider.slides.eq(pos).hide().css("z-index","5");
   slider.slides.eq(pos).fadeIn();

  
  
  slider.on(pos);
  //slider.text(slider.slides.eq(pos).attr("alt"));
  slider.cur=pos;
 },
 on:function(pos){
  //$('#slide-nav a').removeClass('on');
  //$('#slide-nav a#slide-link-'+pos).addClass('on');
 },
 text:function(di){

  slider.cr['b']=di;
  slider.ticker('#slide-desc',di,0,'b');
 },
 ticker:function(el,text,pos,unique){
  if(slider.cr[unique]!=text)
   return false;

  ctext=text.substring(0,pos)+(pos%2?'-':'_');
  $(el).html(ctext);

  if(pos==text.length)
   $(el).html(text);
  else
   window.setTimeout('slider.ticker("'+el+'","'+text+'",'+(pos+1)+',"'+unique+'");',30);
 }
};
