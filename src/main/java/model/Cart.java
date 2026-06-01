package model;

import java.math.BigDecimal;

public class Cart {
    private int id;
    private int userId;
    private int perfumeId;
    private int quantity;
    
    // Thêm các trường hỗ trợ hiển thị
    private String perfumeName;
    private String imageUrl;
    private BigDecimal price;

    public Cart() {}

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public int getPerfumeId() { return perfumeId; }
    public void setPerfumeId(int perfumeId) { this.perfumeId = perfumeId; }

    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }

    public String getPerfumeName() { return perfumeName; }
    public void setPerfumeName(String perfumeName) { this.perfumeName = perfumeName; }

    public String getImageUrl() { return imageUrl; }
    public void setImageUrl(String imageUrl) { this.imageUrl = imageUrl; }

    public BigDecimal getPrice() { return price; }
    public void setPrice(BigDecimal price) { this.price = price; }
    
    public BigDecimal getTotal() {
        if (price == null) return BigDecimal.ZERO;
        return price.multiply(new BigDecimal(quantity));
    }
}
