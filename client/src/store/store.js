import { configureStore } from "@reduxjs/toolkit";
import cartReducer from "../reducer/cartReducer";
import userReducer from "../reducer/userReducer";
export default configureStore({
  reducer: {
    cart: cartReducer,
    user: userReducer,
  },
});
