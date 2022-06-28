import { createSlice } from "@reduxjs/toolkit";

const cartSlice = createSlice({
  name: "cart",
  initialState: {
    quantity: 0,
    products: [],
    total: 0,
  },
  reducers: {
    addProduct: (state, action) => {
      const existProduct = state.products.filter(
        (item) => item._id === action.payload._id
      );
      if (existProduct.length !== 0) {
        state.products.forEach((item) => {
          if (item._id === action.payload._id) {
            item.quantity += action.payload.quantity;
          }
        });
      } else {
        state.products.push(action.payload);
      }
      state.total += action.payload.price * action.payload.quantity;
      state.quantity += action.payload.quantity;
    },
  },
});

export const { addProduct } = cartSlice.actions;
export default cartSlice.reducer;
