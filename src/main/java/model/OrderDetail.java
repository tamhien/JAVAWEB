package model;

import java.math.BigDecimal;

public class OrderDetail {
    private int id;
    private int orderId;
    private int perfumeId;
    private int quantity;
    private BigDecimal price;

    // Hỗ trợ hiển thị
    private String perfumeName;
    private String imageUrl;

    public OrderDetail() {}

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getOrderId() { return orderId; }
    public void setOrderId(int orderId) { this.orderId = orderId; }

    public int getPerfumeId() { return perfumeId; }
    public void setPerfumeId(int perfumeId) { this.perfumeId = perfumeId; }

    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }

    public BigDecimal getPrice() { return price; }
    public void setPrice(BigDecimal price) { this.price = price; }

    public String getPerfumeName() { return perfumeName; }
    public void setPerfumeName(String perfumeName) { this.perfumeName = perfumeName; }

    public String getImageUrl() { return imageUrl; }
    public void setImageUrl(String imageUrl) { this.imageUrl = imageUrl; }
}
