import styled from "styled-components";
import { popularProducts } from "../data";
import Product from "./Product";
import axios from "axios";
import { useEffect, useState } from "react";

const Container = styled.div`
  padding: 20px;
  display: flex;
  flex-wrap: wrap;
  justify-content: space-between;
`;

const Products = ({ cat, filters, sort }) => {
  const [products, setProducts] = useState([]);
  const [filteredProducts, setFilteredProducts] = useState([]);
  useEffect(() => {
    const getData = async () => {
      const data = await axios.get(
        cat
          ? `http://localhost:5000/api/products?category=${cat}`
          : "http://localhost:5000/api/products"
      );
      setProducts(data.data);
    };
    getData();
  }, [cat]);
  useEffect(() => {
    // if (filters && Object.entries(filters).length !== 0) {
    //   setFilteredProducts(
    //     products.filter((item) =>
    //       Object.entries(filters).every(([key, value]) =>
    //         item[key].includes(value)
    //       )
    //     )
    //   );
    // } else {
    //   console.log(products);
    //   setFilteredProducts(products);
    // }
    cat &&
      setFilteredProducts(
        products.filter((item) =>
          Object.entries(filters).every(([key, value]) =>
            item[key].includes(value)
          )
        )
      );
  }, [filters, cat, products]);
  console.log(filteredProducts);
  return (
    <Container>
      {cat
        ? filteredProducts.map((pItem) => (
            <Product key={pItem.id} pItem={pItem} />
          ))
        : products
            .slice(0, 8)
            .map((pItem) => <Product key={pItem.id} pItem={pItem} />)}
    </Container>
  );
};

export default Products;
