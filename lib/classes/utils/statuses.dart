import 'package:car_pool/classes/themes/light_theme.dart';
import 'package:flutter/material.dart';

enum OrderStatus { pending, approved, rejected, none }

enum TripStatus { pending, ongoing, completed }

String tripToString(TripStatus status) {
  switch (status) {
    case TripStatus.pending:
      return "Pending";
    case TripStatus.ongoing:
      return "Ongoing";
    case TripStatus.completed:
      return "Completed";
    default:
      return "Pending";
  }
}

TripStatus stringToTripStatus(String strStatus) {
  switch (strStatus) {
    case "Pending":
      return TripStatus.pending;
    case "Ongoing":
      return TripStatus.ongoing;
    case "Completed":
      return TripStatus.completed;
    default:
      return TripStatus.pending;
  }
}

String statusToString(OrderStatus status) {
  switch (status) {
    case OrderStatus.pending:
      return "Pending";
    case OrderStatus.approved:
      return "Approved";
    case OrderStatus.rejected:
      return "Rejected";
    default:
      return "Pending";
  }
}

OrderStatus stringToStatus(String strStatus) {
  switch (strStatus) {
    case "Pending":
      return OrderStatus.pending;
    case "Approved":
      return OrderStatus.approved;
    case "Rejected":
      return OrderStatus.rejected;
    default:
      return OrderStatus.pending;
  }
}

Color getStatusColor(OrderStatus status) {
  switch (status) {
    case OrderStatus.pending:
      return LightTheme.pending;
    case OrderStatus.approved:
      return LightTheme.accept;
    case OrderStatus.rejected:
      return LightTheme.decline;
    default:
      return LightTheme.pending;
  }
}

Color getTripStatusColor(TripStatus status) {
  switch (status) {
    case TripStatus.pending:
      return LightTheme.pending;
    case TripStatus.ongoing:
      return LightTheme.decline;
    case TripStatus.completed:
      return LightTheme.accept;
    default:
      return LightTheme.pending;
  }
}

TripStatus goToNextStatus(TripStatus status) {
  switch (status) {
    case TripStatus.pending:
      return TripStatus.ongoing;
    case TripStatus.ongoing:
      return TripStatus.completed;
    case TripStatus.completed:
      return TripStatus.completed;
    default:
      return TripStatus.pending;
  }
}
