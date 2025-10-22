const Product = require("../models/product");
const ApiFeature = require("../utils/apiFeatures");
const catchasyncerror = require("../middleware/catchasyncerror");
const ErrorHandler = require("../utils/errorHandler");
const cloudinary = require("cloudinary")

//create a product 

exports.creatProduct = catchasyncerror(async(req,res,next)=>{
    let images = [];

    if (typeof req.body.images === "string") {
      images.push(req.body.images);
    } else {
      images = req.body.images;
    }
  
    const imagesLinks = []; 
  
    for (let i = 0; i < images.length; i++) {
      const result = await cloudinary.v2.uploader.upload(images[i], {
        folder: "products",
      });
  
      imagesLinks.push({
        public_id: result.public_id,
        url: result.secure_url,
      });
    }
  
    req.body.images = imagesLinks; 
    req.body.user = req.user.id;
    
    const product = await Product.create(req.body);
    res.status(200).json({
        success:true,
        product,
        message:"product created"
    })

})
 
//get all products  --admin 

exports.getAllProduct = catchasyncerror( async(req,res,next)=>{
  
    const product = await Product.find();
    res.status(200).json({
        success:true,
        product

    })
})

//get product by id

exports.getProductbyid = catchasyncerror(async(req,res,next)=>{
    const product = await Product.findById(req.params.id)
    if(!product){
       return next(new ErrorHandler("product not found",404))
    }
   //if product found
   res.status(200).json({
    success:true,
    product  
   }) 
})

//get product --admin
exports.getAdminProducts = catchasyncerror(async (req, res, next) => {
    const products = await Product.find();
  
    res.status(200).json({
      success: true,
      products,
    });
  });

//update product 

exports.updateProduct = catchasyncerror(async (req, res, next) => {
  let product = await Product.findById(req.params.id);

  if (!product) {
    return next(new ErrorHandler("Product not found", 404));
  }

  // Images Start Here
  let images = [];

  if (typeof req.body.images === "string") {
    images.push(req.body.images);
  } else {
    images = req.body.images;
  }

  if (images !== undefined) {
    // Deleting Images From Cloudinary
    for (let i = 0; i < product.images.length; i++) {
      await cloudinary.v2.uploader.destroy(product.images[i].public_id);
    }

    const imagesLinks = [];

    for (let i = 0; i < images.length; i++) {
      const result = await cloudinary.v2.uploader.upload(images[i], {
        folder: "products",
      });

      imagesLinks.push({
        public_id: result.public_id,
        url: result.secure_url,
      });
    }

    req.body.images = imagesLinks;
  }

  product = await Product.findByIdAndUpdate(req.params.id, req.body, {
    new: true,
    runValidators: true,
    useFindAndModify: false,
  });

  res.status(200).json({
    success: true,
    product,
  });
});
//delete products 

exports.deleteProduct = catchasyncerror( async(req,res,next)=>{
    let product  = await Product.findByIdAndDelete(req.params.id);
    if(!product){
        res.status(500).json({
            success:false,
            message:"coundn't found the product"
        })
    }
    res.status(200).json({
        success:true,
        product,
        message:"successfully deleted"
    })
})

//get delete product 

