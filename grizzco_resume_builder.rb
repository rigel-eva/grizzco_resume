require "rmagick"
PEN_FONT="./Hanzipen.ttc"
STAMP_FONT="./Splatfont2.ttf"
X={
  "employee_name"=>327,
  "part_timer"=>314,
  "go_getter"=>478,
  "overachiver"=>314,
  "profreshional"=>478,
  "profreshional_rank"=>607,
  "shooter"=>134,
  "charger"=>134,
  "roller"=>134,
  "dualies"=>134,
  "slosher"=>134,
  "blaster"=>312,
  "splatling"=>312,
  "brella"=>312,
  "brush"=>312,
  "n/a"=>312,
  "sw0"=>88,
  "sw1"=>168,
  "sw2"=>249
}
Y={
  "employee_name"=>178,
  "part_timer"=>239,
  "go_getter"=>239,
  "overachiver"=>275,
  "profreshional"=>275,
  "profreshional_rank"=>263,
  "shooter"=>380,
  "charger"=>442,
  "roller"=>516,
  "dualies"=>590,
  "slosher"=>658,
  "blaster"=>377,
  "splatling"=>439,
  "brella"=>515,
  "brush"=>592,
  "n/a"=>657,
  "sw0"=>912,
  "sw1"=>912,
  "sw2"=>912
}
WIDTH={
  "employee_name"=>357,
  "profreshional_rank"=>74,
  "sw0"=>66,
  "sw1"=>79,
  "sw2"=>76
}
HEIGHT={
  "employee_name"=>30,
  "profreshional_rank"=>30,
  "sw0"=>35,
  "sw1"=>35,
  "sw2"=>35
}
CHECK_WIDTH=14
CHECK_HEIGHT=15

RESUME=Magick::ImageList.new("grizzco_resume.png")
CROSS=Magick::ImageList.new("X_mark.png")
def writeResume(name,rank,weapon,code=nil,profreshional_rank=0)
  pen=Magick::Draw.new
  pen.font=PEN_FONT
  pen.gravity=Magick::WestGravity
  pen.pointsize = 30
  pen.fill = "#000000"
  pen.font_weight = Magick::BoldWeight
  resume=RESUME
  resume.annotate(pen,WIDTH["employee_name"],HEIGHT["employee_name"],X["employee_name"],Y["employee_name"],name)
  if(rank=="profreshional")
    resume.annotate(pen,WIDTH["profreshional_rank"],HEIGHT["profreshional_rank"],X["profreshional_rank"],Y["profreshional_rank"],"#{profreshional_rank}")
  end
  unless(code.nil?)

    stamp=Magick::Draw.new
    stamp.font=STAMP_FONT
    stamp.pointsize=30
    stamp.gravity=Magick::WestGravity
    stamp.font_weight = Magick::BoldWeight
    stamp.fill="#FF0000"
    c2=code.split("-")
    (0..2).each{|i|
      resume.annotate(stamp,WIDTH["sw#{i}"],HEIGHT["sw#{i}"],X["sw#{i}"],Y["sw#{i}"],c2[-3+i])
    }
  end
  resume.composite!(CROSS,X[rank],Y[rank],Magick::AtopCompositeOp)
  resume.composite!(CROSS,X[weapon],Y[weapon],Magick::AtopCompositeOp)
  resume.format="png"
  return resume
end
writeResume("Rigel","profreshional","brella","SW-1952-8388-9297",40).write("resume-composite.png")
