const express=require('express');
const router=express.Router();
const Terreno=require('../models/Terreno');

//Registrar Terreno

router.post('/',async(req,res)=>{
try{
    const ter=new Terreno(req.body);
    await ter.save();
    res.status(201).json(ter);
}catch(error){
    res.status(400).json({error:error.message});
}
});

//Consultar general

router.get('/',async(req,res)=>{
try{
    const ter=await Terreno.find();
    res.json(ter);
}catch(error){
    res.status(500).json({error:error.message});
}
});

//Cantidad de registros
router.get('/count', async (req, res) => {
  try {
    const count = await Terreno.countDocuments();
    res.json({ count });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

//Consultar los nombres de terreno
router.get('/nombres', async (req, res) => {
  try {
    const nombres = await Terreno.find().select('nombre -_id');
    res.json(nombres.map(ter=> ter.nombre));
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

//Consulta los terrenos que se encuentran aptos 
router.get('/aptos', async (req, res) => {
  try {
    const aptos = await Terreno.find({ estado: 'Apto' });
    res.json(aptos);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

//Consulta de entradas y salidas de los terrenos
router.get('/fechas', async (req, res) => {
  try {
    const fechas = await Terreno.find().select('nombre fechaIngreso fechaSalida -_id');
    res.json(fechas);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Consulta de los días en terreno 
router.get('/dias', async (req, res) => {
  try {
    const terrenos = await Terreno.find();
    const result = terrenos.map(t => ({
      nombre: t.nombre,
      dias: t.dias 
    }));
    res.json(result);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

//Consulta especifica
router.get('/:id', async (req, res) => {
    try {
        const ter = await Terreno.findById(req.params.id);
        if (!ter) return res.status(404).json({ error: "terreno no encontrado" });
        res.json(ter);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

//Modificar 

router.put('/:id',async(req,res)=>{
try{
    const ter=await 
    Terreno.findByIdAndUpdate(req.params.id, req.body, {new:true});
    if (!ter)return res.status(404).json({error:"Terreno no encontrado"});
    res.json(ter);
}catch(error){
    res.status(500).json({error:error.message});
}
});

//Eliminar 

router.delete('/:id',async(req,res)=>{
try{
    const ter=await 
    Terreno.findByIdAndDelete(req.params.id);
    if (!ter)return res.status(404).json({error:"Terreno no encontrado"});
    res.json(ter);
}catch(error){
    res.status(500).json({error:error.message});
}
});

module.exports=router;

