const mongoose=require('mongoose');

const terrenoSchema=new mongoose.Schema({
    nombre:{type:String,require:true},
    estado:{type:String,require:true},
    fechaIngreso:{type:Date,require:true},
    fechaSalida:{type:Date,require:true}
});

terrenoSchema.virtual('dias').get(function() {
  if (this.fechaIngreso && this.fechaSalida) {
    const diffTime = this.fechaSalida - this.fechaIngreso;
    const diffDays = Math.ceil(diffTime / (1000 * 60 * 60 * 24));
    return diffDays;
  }
  return 0;
});

terrenoSchema.set('toJSON', { virtuals: true });
terrenoSchema.set('toObject', { virtuals: true });

module.exports=mongoose.model('Terreno',terrenoSchema)